module Api::V1
  # Comments Controller
  class CommentsController < ApplicationController
    def create
      puts "


      helo


      "
      post_id = params[:post_id]
      @post = Post.find(post_id)
      @comment = Comment.new(comment_params.merge( user_id: current_user.id, post_id: post_id))
      puts "Hello jamie"
      if @comment.save
        puts "Hello Jon"
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
      # @comment = @post.comments.create(comment_params.merge( user_id: current_user.id, post_id: post_id))
      # redirect_to posts_url
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to posts_url
    end

    def edit
      @comment = Comment.find(params[:id])
    end

    def update
      @comment = Comment.find(params[:id])
      @comment.update(comment_params) ? (redirect_to posts_url) : (render 'edit')
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end
  end
end
