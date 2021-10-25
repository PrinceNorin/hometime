FactoryBot.define do
  factory :reservation do
    guest
    sequence(:code) { |n| "xxx1234#{n}" }
    currency { 'AUD' }
    status { 'accepted' }
    start_date { Date.current }
    end_date { 1.day.from_now }
    number_of_nights { 1 }
    number_of_guests { 1 }
    number_of_adults { 1 }
  end
end
