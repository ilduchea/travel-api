Review.destroy_all
User.destroy_all
Destination.destroy_all

15.times do |i|
  email = Faker::Lorem.words(1)
  User.create!(
    name: Faker::HitchhikersGuideToTheGalaxy.character,
    email: "#{email}#{i}@email.com",
    password: 'password',
    id: i+1
  )
end

50.times do |i|
  destination = Destination.create!(
    name: Faker::LordOfTheRings.location,
    city: Faker::Address.city,
    locale: Faker::Address.state,
    country: Faker::Address.country
  )
  n = Faker::Number.between(1, 5)
  n.times do |index|
    destination.reviews.create!(
      content: Faker::HitchhikersGuideToTheGalaxy.quote,
      heading: Faker::HitchhikersGuideToTheGalaxy.specie,
      rating: Faker::Number.between(1, 5),
      user_id: Faker::Number.between(1, 15)
    )
  end
end
