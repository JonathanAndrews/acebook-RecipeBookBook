FactoryBot.define do
  factory :comment do
    commenter { "MyString" }
    body { "MyText" }
    post { nil }
    user { nil }
  end

  factory :user do
    email { 'joe3@gmail.com' }
    password { 'blabla' }
    id { 1 }
  end

  factory :user_2, class: User do
    email { 'fred@gmail.com' }
    password { 'secure_Pa$$word_1!' }
    id { 2 }

  factory :post do
    message { 'helloooooooo' }
    id { 1 }
  end
end
