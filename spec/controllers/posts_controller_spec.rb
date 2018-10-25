
# frozen_string_literal: true

require 'rails_helper'
require 'helpers/post_helper_spec.rb'

RSpec.describe PostsController, type: :controller do

  before(:each) do
    @user = build(:user)
    @user.confirm
    sign_in @user
    @user_2 = build(:user_2)
    @user_2.confirm
  end

  describe 'GET posts/new ' do
    it 'responds with 200' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      create_post('Hello, world!')
      expect(response).to redirect_to(posts_url)
    end

    it 'creates a post' do
      create_post('Hello, world!')
      expect(Post.find_by(message: 'Hello, world!')).to be
    end
  end

  describe 'GET /' do
    it 'responds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /posts/:id/edit' do
    it 'routes /posts/1/edit to posts#edit' do
      expect(get: "/posts/1/edit").to route_to(
        controller: "posts",
        action: "edit",
        id: "1"
      )
    end

    context 'within 10 minutes of creation' do
      it 'can edit own post' do
        create_post('Hello, world!')
        new_post = Post.find_by(message: 'Hello, world!')
        new_post_id = new_post.id
        new_message = 'Hello, Aliens!'
        patch :update, params: { post: { message: new_message }, id: new_post_id }
        updated_post = Post.find_by(message: new_message)
        expect(updated_post.message).to eq(new_message)
        expect(updated_post.id).to eq(new_post_id)
      end

      it "cannot edit another user's post" do
        create_post('Hello, world!')
        new_post = Post.find_by(message: 'Hello, world!')
        new_post_id = new_post.id
        sign_out @user
        sign_in @user_2
        new_message = 'Hello, Aliens!'
        expect {
          patch :update,
          params: { post: { message: new_message }, id: new_post_id }
        }.to raise_error("Cannot edit another user's post")
      end
    end

    context 'after 10 minutes from creation' do
      it 'cannot edit a post' do
        @future_time = Time.now + 601
        create_post('Hello, world!')

        allow(Time).to receive(:now).and_return(@future_time)

        newPost = Post.find_by(message: 'Hello, world!')
        newPostID = newPost.id
        newMessage = 'Hello, Aliens!'
        expect{ patch :update, params: { post: { message: newMessage },
        id: newPostID } }.to raise_error(
          "Sorry! Too late to edit, be snappier next time"
        )
      end
    end
  end

  describe 'DELETE Posts' do
    it 'validate route DELETE /posts/:id to posts#destroy' do
      expect(delete: "/posts/1").to route_to(
        controller: "posts",
        action: "destroy",
        id: "1"
      )
    end

    it 'should delete own post' do
      create_post('Post by user 1 to be deleted')
      new_post = Post.find_by(message: 'Post by user 1 to be deleted')
      new_post_id = new_post.id
      delete :destroy, params: { id: new_post_id }
      expect(Post.find_by(id: new_post_id)).to be_nil
    end

    it "should not delete another user's post" do
      create_post('Post by user 1 to be deleted')
      new_post = Post.find_by(message: 'Post by user 1 to be deleted')
      new_post_id = new_post.id
      sign_out @user
      sign_in @user_2
      expect { delete :destroy, params: { id: new_post_id } }.to raise_error(
        "Cannot delete another user's post"
      )
    end
  end
end
