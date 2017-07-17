require 'faker'

FactoryGirl.define do
  factory :review do
    content Faker::HitchhikersGuideToTheGalaxy.quote
    heading Faker::HitchhikersGuideToTheGalaxy.specie
    rating rand(1..5)
  end
  factory :user do
    name 'Qwerty Jr'
    email 'qwertyjr1@email.com'
    password 'password'
  end
  # factory :admin, class: User do
  #   name 'Qwerty'
  #   email 'qwerty@email.com'
  #   password 'password'
  #   admin true
  # end
  factory :destination do
    name Faker::LordOfTheRings.location
    city Faker::Address.city
    locale Faker::Address.state
    country Faker::Address.country
  end
end
