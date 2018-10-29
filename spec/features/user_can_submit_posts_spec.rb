# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Timeline', type: :feature do
  xscenario 'Can submit posts and view them' do
    post_hello_world
    expect(page).to have_content('Hello, world!')
  end
end
