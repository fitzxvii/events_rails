FactoryBot.define do
  factory :event do
    name { "Sample Event 1" }
    date { "2024-07-07" }
    city { "Boston" }
    state { "MA" }
    user 
  end
end
