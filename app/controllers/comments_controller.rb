class CommentsController < ApplicationController

  def create 
    post_id = params[:post_id]
    @post = Post.find(post_id)
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id, post_id: post_id))
    redirect_to posts_url
  end 

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
