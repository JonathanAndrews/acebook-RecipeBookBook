# frozen_string_literal: true
# usual order of actions is:
# index, show, new, edit, create, update and destroy

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
    if !post_created_within_ten_minutes?
      redirect_to posts_url, alert: 'Sorry! Too late to edit, be snappier next time'
    else
      @post
    end
  end

  def create
    @post = Post.create(post_params.merge(user_id: current_user.id))
    redirect_to posts_url
  end

  def update
    @post = Post.find(params[:id])
    raise "Cannot edit another user's post" unless
      post_created_by_current_user?
    @post.update(post_params) ? (redirect_to @post) : (render 'edit')
  end

  def destroy
    @post = Post.find(params[:id])
    raise("Cannot delete another user's post") unless
      post_created_by_current_user?

    @post.destroy
    redirect_to posts_url, notice: "Delete successful"
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
