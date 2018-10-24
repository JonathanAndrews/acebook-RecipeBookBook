
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @user = build(:user)
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
      post :create, params: { post: { message: 'Hello, world!' } }
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
      expect(get: '/posts/1/edit').to route_to(
        controller: 'posts',
        action: 'edit',
        id: '1'
      )
    end

    # it 'can edit a post' do
    #   post :create, params: { post: { message: 'Hello, world!' } }
    #   a = Post.find_by(message: 'Hello, world!')
    #   id = a.id
    #   patch :update, params: { post: {id: id, message: 'Hello, Aliens!' } }
    #   expect(Post.find_by(message: 'Hello, Aliens!')).to be
    # end
  end
end
