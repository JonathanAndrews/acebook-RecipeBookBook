class CommentsController < ApplicationController
    
    def show
        @comment = Comment.find(params[:id])
    end 

    def new
        @comment = Comment.new
    end

    def create 
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
        redirect_to posts_url
    end 

    private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
