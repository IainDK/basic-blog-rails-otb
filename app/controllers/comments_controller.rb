class CommentsController < ApplicationController

  before_action :require_permisson, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to '/'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def require_permisson
    comment = Comment.find(params[:id])
    unless current_user == comment.user
      flash[:notice] = "You do not have persmission to perform this action."
      redirect_to posts_path
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
