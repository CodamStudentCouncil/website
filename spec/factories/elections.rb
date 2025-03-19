FactoryBot.define do
  factory :election do
    sequence(:start_date) { |n| Time.zone.now.to_date + n     }
    sequence(:end_date)   { |n| Time.zone.now.to_date + n + 7 }

    factory(:election_with_votes) do
      votes { build_list(:vote, 5) }
      registrations { build_list(:registration, 5) }
    end
  end
end
