# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Tests - Posts', type: :feature do
  scenario 'Can submit posts and view them' do
    visit '/'
    user = user_sign_in
    post_hello_world
    expect(page).to have_content('Hello, world!')
    expect(page.find_by_id('post_1_author')).to have_content(user.email)
  end

  scenario 'Can submit posts and edit them' do
    visit '/'
    user_sign_in
    post_hello_world
    click_link 'Edit'
    fill_in 'Message', with: "Goodbye world"
    click_button 'Submit'
    expect(page).to have_content('Goodbye world')
  end

  scenario 'Can delete posts and see flash confirmation' do
    visit '/'
    user_sign_in
    post_hello_world
    click_link 'Delete'
    expect(page).to_not have_content('Goodbye world')
    expect(page).to have_content('Delete successful')
  end

  scenario 'Cannot edit own post after 10 minutes' do
    visit '/'
    user_sign_in
    post_hello_world
    @future_time = Time.now + 601
    allow(Time).to receive(:now).and_return(@future_time)
    click_link 'Edit'
    expect(current_path).to eq('/posts')
    expect(page).to have_content('Sorry! Too late to edit, be snappier next time')
  end

  scenario "Cannot update other user's posts" do
    visit '/'
    user_sign_in
    post_hello_world
    click_link 'Logout'
    visit '/'
    user2_sign_in
    visit '/posts'
    expect(page.find_by_id('post_1')).to have_no_link('Edit')
  end
end
