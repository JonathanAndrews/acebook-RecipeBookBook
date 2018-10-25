
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before(:each) do
    @user = build(:user)
    puts "11111111111111111111111111111111111111111111111111111111111"
    puts @user.id
    @user.confirm
    sign_in @user
  end

  describe 'GET /new ' do
    it 'responds with 200' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(response).to redirect_to(posts_url)
    end

    it 'creates a post' do
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # sign_in users(:testuser)
      post :create, params: { post: { message: 'Hello, world!', user_id: @user.id}  }
      expect(Post.find_by(message: 'Hello, world!')).to be
    end
  end

  describe 'GET /' do
    it 'responds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /:id/edit' do
    it 'routes /posts/1/edit to posts#edit' do
      expect(get: "/posts/1/edit").to route_to(
        controller: "posts",
        action: "edit",
        id: "1"
      )
    end

    context 'within 10 minutes of creation' do
      it 'can edit a post' do
        post :create, params: { post: { message: 'Hello, world!' } }
        newPost = Post.find_by(message: 'Hello, world!')
        newPostID = newPost.id
        newMessage = 'Hello, Aliens!'
        patch :update, params: { post: { message: newMessage }, id: newPostID }
        updatedPost = Post.find_by(message: newMessage)
        expect(updatedPost.message).to eq(newMessage)
        expect(updatedPost.id).to eq(newPostID)
      end
    end

    context 'after 10 minutes from creation' do
      # before (:each) do
      #   @future_time = Time.now + 601
      #   # allow(Time).to receive(:now).and_return(@future_time)
      # end
      it 'cannot edit a post' do
        @future_time = Time.now + 601
        post :create, params: { post: { message: 'Hello, world!' } }

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
end
