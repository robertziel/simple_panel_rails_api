FactoryBot.define do
  factory :authentication_token do
    association :user
    ip { Faker::Internet.ip_v4_address }
  end
end
