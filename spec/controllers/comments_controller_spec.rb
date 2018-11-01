# frozen_string_literal: true

require 'rails_helper'
require 'helpers/comments_helper_spec.rb'


RSpec.describe Api::V1::CommentsController, type: :controller do
  before(:each) do
    @user = build(:user)
    @user.confirm
    sign_in @user
    @post = create(:post)
  end

  describe 'CREATE POST / ' do
    context 'successful creation' do
      it 'responds with 201' do
        create_comment('Hello, potato!', @post.id)
        expect(response).to have_http_status(201)
      end

      it 'returns new comment json' do
        create_comment('Hello json', @post.id)
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(1)
        expect(json["body"]).to eq("Hello json")
        expect(json["user_id"]).to eq(1)
        expect(json["post_id"]).to eq(1)
      end

      it 'creates a comment' do
        create_comment('Hello, world!', @post.id)
        expect(Comment.find_by(body: 'Hello, world!')).to be
      end
    end 
  end

  describe 'DELETE Comments' do
    it 'deletes a comment' do
      create_comment('Hello, potato!', @post.id)
      comment = Comment.find_by(body: "Hello, potato!")
      comment_id = comment.id
      delete :destroy, params: { post_id: @post.id, id: comment_id }
      expect(Comment.find_by(id: comment_id)).to be_nil
    end

    it 'responds with 204' do
      create_comment('Hello, potato!', @post.id)
      comment = Comment.find_by(body: 'Hello, potato!')
      comment_id = comment.id
      delete :destroy, params: { post_id: @post.id, id: comment_id }
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET /posts/:id/comments/:id/edit' do
    xit 'routes posts/1/comments/1/edit to comments#edit' do
      expect(get: 'posts/1/comments/1/edit').to route_to(
        controller: 'comments',
        action: 'edit',
        post_id: '1',
        id: '1'
      )
    end
  end

  describe 'UPDATE PATCH' do
    context 'successful update' do
      it 'responds with 204' do
        create_comment('Hello, potato!', @post.id)
        comment = Comment.find_by(body: 'Hello, potato!')
        new_body = 'Hello, orange!'
        update_comment(new_body , @post.id, comment.id)
        expect(response).to have_http_status(204)
      end

      it 'updates comment' do
        create_comment('Hello, potato!', @post.id)
        comment = Comment.find_by(body: 'Hello, potato!')
        new_body = 'Hello, orange!'
        update_comment(new_body , @post.id, comment.id)
        updated_comment = Comment.find_by(body: new_body )
        expect(updated_comment.body).to eq(new_body)
        expect(updated_comment.id).to eq(comment.id)
      end
    end

    xit 'redirects to edit after unsuccessful updating' do
      create_comment('Hello, potato!', @post.id)
      comment = Comment.find_by(body: 'Hello, potato!')
      update_comment('' , @post.id, comment.id)
      expect(response).to render_template('edit')
    end
  end
end
