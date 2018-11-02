# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments feature test', type: :feature do
  scenario 'Can fill in form' do
    user_sign_in
    post_hello_world
    comment_hello_aliens
    expect(current_path).to eq('/posts')
    expect(page).to have_content('Hello, Aliens')
  end

  scenario 'should find a back to posts link' do
    user_sign_in
    post_hello_world
    click_link 'Add comment'
    expect(page).to have_link("Back to posts")
  end

  scenario 'Comment author displayed next to their comment' do
    user_sign_in
    post_hello_world
    comment_hello_aliens
    expect(current_path).to eq('/posts')
    expect(page.find_by_id('comment_1')).to have_content(@user.email.to_s)
  end
end
