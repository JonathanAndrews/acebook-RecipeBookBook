# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Logout', type: :feature do
  scenario 'User can Logout' do
    @user = build(:user)
    @user.confirm
    visit '/users/sign_in'
    fill_in 'user_email', with: 'joe3@gmail.com'
    fill_in 'user_password', with: 'blabla'
    click_button 'Log in'
    click_link 'Logout'
    expect(page).to have_content(
      'You need to sign in or sign up before continuing.')
  end
end
