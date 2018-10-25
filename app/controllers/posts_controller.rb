# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.create(post_params.merge(user_id: current_user.id))
    redirect_to posts_url
  end

  def update
    @post = Post.find(params[:id])
    raise("Cannot edit another user's post") unless
      post_created_by_current_user?
    raise('Sorry! Too late to edit, be snappier next time') unless
      post_created_within_ten_minutes?

    @post.update(post_params) ? (redirect_to @post) : (render 'edit')
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end

  def can_edit_post?
    post_created_by_current_user? && post_created_within_ten_minutes?
  end

  def post_created_by_current_user?
    @post.user_id === current_user.id
  end

  def post_created_within_ten_minutes?
    Time.current - @post.created_at <= 600
  end
end
