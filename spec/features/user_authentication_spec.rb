# frozen_string_literal: true

require 'rails_helper'

# RSpec.feature 'Sign Up', type: :feature do
#   scenario 'Can sign up' do
#     sign_up
#     expect(page).to have_content(
#       'You need to sign in or sign up before continuing.')
#   end

#   scenario 'User must confirm email before logging in' do
#     sign_up
#     fill_in 'user_email', with: 'hello@world.com'
#     fill_in 'user_password', with: '123456'
#     click_button 'Log in'
#     expect(page).to have_content(
#       'You have to confirm your email address before continuing.')
#   end
# end

RSpec.feature 'Sign In', type: :feature do
  scenario 'User can sign in' do
    user_sign_in
    expect(page).to have_content("Logged in as #{@user.email}")
  end
end

RSpec.feature 'Logout', type: :feature do
  scenario 'User can Logout' do
    user_sign_in
    click_link 'Logout'
    expect(page).to have_content(
      'You need to sign in or sign up before continuing.')
  end
end
