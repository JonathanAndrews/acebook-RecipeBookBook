require 'rails_helper'


# RSpec.describe PostsHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

def create_post(message)
  post :create, params: { post: { message: message, user_id: @user.id } }
end
