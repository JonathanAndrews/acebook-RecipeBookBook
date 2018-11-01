# frozen_string_literal: true
# usual order of actions is:
# index, show, new, edit, create, update and destroy

module Api::V1
  # Posts Controller
  class PostsController < ApplicationController
    def index
      @posts = Post.all.order('created_at DESC')
      render json: json_nest(@posts)
    end

    def show
      @post = Post.find(params[:id])
      render json: json_nest(@post)
    end

    def create
      @post = Post.new(post_params.merge(user_id: current_user.id))
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      begin
        @post = Post.find(params[:id])

        if post_created_by_current_user?
          if @post.update(post_params)
            head :no_content, status: :ok
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        else
          render json: "Cannot edit another user's post", status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: "Record not found", status: :unprocessable_entity
      end
    end

    def destroy
      begin
        @post = Post.find(params[:id])

        if post_created_by_current_user?
          if @post.destroy
            head :no_content, status: :ok
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        else
          render json: "Cannot delete another user's post", status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: "Record not found", status: :unprocessable_entity
      end
    end

    private

    def post_params
      params.require(:post).permit(:message, :user_id)
    end

    def post_created_by_current_user?
      @post.user_id === current_user.id
    end

    def post_created_within_ten_minutes?
      Time.current - @post.created_at <= 600
    end

    def json_nest(entity)
      entity.as_json(
        include: {
          user: { only: :email },
          comments: {
            include: {
              user: { only: :email }
            }
          }
        }
      )
    end
  end
end
