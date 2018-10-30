def post_hello_world
  visit '/posts'
  click_link 'New post'
  fill_in 'Message', with: 'Hello, world!'
  click_button 'Submit'
end

def comment_hello_aliens
  click_link 'Add comment'
  fill_in 'comment[body]', with: 'Hello, Aliens'
  click_button 'Create Comment'
end

def sign_up
  visit '/users/sign_up'
  fill_in 'user_email', with: 'hello@world.com'
  fill_in 'user_password', with: '123456'
  fill_in 'user_password_confirmation', with: '123456'
  click_button 'Sign up'
end
