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
end
