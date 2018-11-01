module Api::V1
  # Comments Controller
  class CommentsController < ApplicationController
    def create
      post_id = params[:post_id]
      @post = Post.find(post_id)
      @comment = Comment.new(comment_params.merge( user_id: current_user.id, post_id: post_id))
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
    
    def edit
      @comment = Comment.find(params[:id])
    end

    def update
      @comment = Comment.find(params[:id])

      if @comment.update(comment_params) 
        head :no_content, status: :ok
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
      @comment = Comment.find(params[:id])

      if @comment.destroy
        head :no_content, status: :ok
      else
        render json: @comment.errors, status: :unprocessable_entity 
      end
    end
    
    private

    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end
  end
end
