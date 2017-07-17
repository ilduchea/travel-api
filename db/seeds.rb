Review.destroy_all
User.destroy_all
Destination.destroy_all

user = FactoryGirl.create(:user)

50.times do |i|
  destination = FactoryGirl.create(:destination)
  n = Faker::Number.between(1, 5)
  n.times do |index|
    review = FactoryGirl.build(:review)
    destination.reviews.create!(
      content: review.content,
      heading: review.heading,
      rating: review.rating,
      user_id: user.id
    )
  end
end
