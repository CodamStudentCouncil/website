FactoryBot.define do
  factory :candidate do
    sequence(:username) { |n| "user-#{n}" }

    full_name { "Some User" }
    photo_url { "https://fake-image-url.com/image.jpg" }
    campus_ids { [ 14 ] }

    tagline { "Important Things" }
    description { "Lorem ipsum dolor sit amet" }

    election
  end
end
