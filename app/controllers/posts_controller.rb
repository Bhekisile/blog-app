class PostsController < ApplicationController
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
    @post = Post.find(params[:id])
    @user = @post.author
    if @post.destroy
      redirect_to user_path(@user), notice: 'Post was deleted.'
    else
      redirect_to user_path(@user), alert: 'Error deleting the post.'
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to user_path(@user), alert: 'Error deleting the post: There are associated comments.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
