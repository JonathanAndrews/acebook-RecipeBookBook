require 'rails_helper'

def create_comment(body, post_id)
  post :create, params: { comment: { body: body }, post_id: post_id }
end

def update_comment(body, post_id, comment_id)
  patch :update, params: { comment: { body: body }, post_id: post_id, id: comment_id}
end
