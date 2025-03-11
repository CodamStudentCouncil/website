FactoryBot.define do
  factory :registration do
    election
    sequence(:username) { |n| "user#{n}" }
  end
end
