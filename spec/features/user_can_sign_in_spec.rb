# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign In', type: :feature do
  scenario 'User can sign in' do
    @user = build(:user)
    @user.confirm
    visit '/users/sign_in'
    fill_in 'user_email', with: 'joe3@gmail.com'
    fill_in 'user_password', with: 'blabla'
    click_button 'Log in'
    expect(page).to have_content('Logged in as joe3@gmail.com')
  end
end
