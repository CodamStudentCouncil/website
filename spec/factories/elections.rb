FactoryBot.define do
  factory :election do
    sequence(:start_date) { |n| Time.zone.now.to_date + n     }
    sequence(:end_date)   { |n| Time.zone.now.to_date + n + 7 }
  end
end
