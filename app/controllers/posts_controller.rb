class PostsController < ApplicationController
  load_and_authorize_resource

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

  def destroy
    @user = User.find(params[:user_id])
    post = Post.find(params[:id])

    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
