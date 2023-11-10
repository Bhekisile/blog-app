class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:author, :comments).where(author: @user).references(:author)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.recent_comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Post created successfully!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  #   redirect_to user_path(@User), notice: 'Post was deleted.'
  # end

  # def destroy
  #   @user = User.find(params[:user_id])
  #   @post = Post.find(params[:id])
  #   @post.destroy
  #   respond_to(&:turbo_stream)
  #   redirect_to user_posts_path(@users)
  # end

  def destroy
    @user = User.find(params[:user_id])
    post = Post.find(params[:id])
    authorize! :destroy, post

    post.comments.destroy_all
    post.likes.destroy_all
    post.destroy
    respond_to(&:turbo_stream)

    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end

  # def destroy
  #   @post.destroy!
  #   respond_to do |format|
  #     redirect_to user_post_path(@user, post), notice: 'Post deleted successfully'
      # format.json { head :no_content }
  #   end
  # end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
