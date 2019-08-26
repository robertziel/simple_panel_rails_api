FactoryBot.define do
  factory :authentication_token do
    association :user
  end
end
