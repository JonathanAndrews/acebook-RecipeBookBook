# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Feature Tests - Posts', type: :feature do

  scenario 'Can submit posts and view them' do
    visit '/'
    user_sign_in
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    expect(page).to have_content('Hello, world!')
  end

  scenario 'Can submit posts and edit them' do
    visit '/'
    user_sign_in
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    click_link 'Edit'
    fill_in 'Message', with: "Goodbye world"
    click_button 'Submit'
    expect(page).to have_content('Goodbye world')
  end

  scenario 'Can delete posts and see flash confirmation' do
    visit '/'
    user_sign_in
    visit '/posts'
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    click_link 'Delete'
    expect(page).to_not have_content('Goodbye world')
    expect(page).to have_content('Delete successful')
  end

end
