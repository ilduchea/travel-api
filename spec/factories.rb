require 'faker'

FactoryGirl.define do
  factory :review do
    content Faker::HitchhikersGuideToTheGalaxy.quote
    heading Faker::HitchhikersGuideToTheGalaxy.specie
    rating Faker::Number.between(1, 5)
  end
  factory :user do
    name 'Qwerty Jr'
    email 'qwertyjr1@email.com'
    password 'password'
    password_confirmation 'password'
  end
  # factory :admin, class: User do
  #   name 'Qwerty'
  #   email 'qwerty@email.com'
  #   password 'password'
  #   admin true
  # end
  factory :destination do
    name Faker::Address.community
    city Faker::Address.city
    locale Faker::Address.state
    country Faker::Address.country
  end
end
