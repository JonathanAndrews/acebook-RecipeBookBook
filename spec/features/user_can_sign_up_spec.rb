# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign Up', type: :feature do
  scenario 'Can sign up' do
    visit '/users/sign_up'
    fill_in 'user_email', with: 'hello@world.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'User must confirm email before logging in' do
    visit '/users/sign_up'
    fill_in 'user_email', with: 'hello@world.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Sign up'
    fill_in 'user_email', with: 'hello@world.com'
    fill_in 'user_password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('You have to confirm your email address before continuing.')
  end
end
