FactoryBot.define do
  factory :comment do
    commenter { "MyString" }
    body { "MyText" }
    post { nil }
    user { nil }
  end

 factory :user do
   email "joe3@gmail.com"
   password "blabla"
 end

  factory :post do
    message { 'helloooooooo' }
    id { 1 }
  end
end
