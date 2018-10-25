FactoryBot.define do
  factory :user do
    email { 'joe3@gmail.com' }
    password { 'blabla' }
    id { 1 }
  end

  factory :user_2, class: User do
    email { 'fred@gmail.com' }
    password { 'secure_Pa$$word_1!' }
    id { 2 }
  end
end
