# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments feature test', type: :feature do
  scenario 'Comment author displayed next to their comment' do
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
    fill_in 'comment[body]', with: 'Hello, Aliens'
    click_button 'Create Comment'
    expect(current_path).to eq('/posts')
    expect(page.find_by_id('1')).to have_content(@user.email.to_s)
  end
end
