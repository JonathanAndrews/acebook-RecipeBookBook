# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = build(:user)
    @user.confirm
    sign_in @user
    @post = create(:post)
  end

  describe 'POST / ' do
    it 'redirects to /posts' do
      post :create, params: { comment: { body: 'Hello, potato!' }, post_id: @post.id  }
      expect(response).to redirect_to(posts_url)
    end
  end

  describe 'DELETE Comments' do
    it 'validate route DELETE /posts/:id/comments/:id to comments#destroy' do
      expect(delete: '/posts/1/comments/1').to route_to(
        controller: 'comments',
        action: 'destroy',
        id: '1',
        post_id: '1'
      )
    end

    it 'deletes a comment' do
      post :create, params: { comment: { body: 'Hello, potato!' }, post_id: @post.id  }
      comment = Comment.find_by(body: "Hello, potato!")
      comment_id = comment.id
      delete :destroy, params: { post_id: @post.id, id: comment_id }
      expect(Comment.find_by(id: comment_id)).to be_nil
    end
  end
end
