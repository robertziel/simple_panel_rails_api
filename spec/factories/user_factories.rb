FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@gmail.com" }
    password { |n| "password#{n}" }
  end
end
