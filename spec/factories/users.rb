FactoryBot.define do
  factory :user do
    first_name { "Fitz" }
    last_name { "Villegas" }
    email { "fitz@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    city { "Boston" }
    state { "MA" }
  end
end
