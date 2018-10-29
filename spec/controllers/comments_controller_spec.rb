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

  describe 'GET /posts/:id/comments/:id/edit' do
    it 'routes posts/1/comments/1/edit to comments#edit' do
      expect(get: 'posts/1/comments/1/edit').to route_to(
        controller: 'comments',
        action: 'edit',
        post_id: '1',
        id: '1'
      )
    end
  end

  describe 'PATCH' do
    it 'updates comment' do
      post :create, params: { comment: { body: 'Hello, potato!' }, post_id: @post.id  }
      comment = Comment.find_by(body: 'Hello, potato!')
      new_body = 'Hello, orange!'
      patch :update, params: { comment: { body: new_body }, post_id: @post.id, id: comment.id}
      updated_comment = Comment.find_by(body: new_body )
      expect(updated_comment.body).to eq(new_body)
      expect(updated_comment.id).to eq(comment.id)
    end

    it 'redirects to posts_url after successful updating' do
      post :create, params: { comment: { body: 'Hello, potato!' }, post_id: @post.id  }
      comment = Comment.find_by(body: 'Hello, potato!')
      patch :update, params: { comment: { body: 'Hello, orange!' }, post_id: @post.id, id: comment.id}
      expect(response).to redirect_to(posts_url)
    end

    it 'redirects to edit after unsuccessful updating' do
      post :create, params: { comment: { body: 'Hello, potato!' }, post_id: @post.id  }
      comment = Comment.find_by(body: 'Hello, potato!')
      patch :update, params: { comment: { body: '' }, post_id: @post.id, id: comment.id}
      expect(response).to render_template('edit')
    end
  end
end
