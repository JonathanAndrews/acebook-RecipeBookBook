# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Single post link', type: :feature do
  scenario 'Can see single post link' do
    @user = build(:user)
    @user.confirm
    visit '/users/sign_in'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password 
    click_button 'Log in'
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    click_link 'Add comment'
    expect(page).to have_link("Back to posts")
  end
end