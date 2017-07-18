require 'rails_helper'

describe "get all reviews route", :type => :request do
  let!(:user) {
    FactoryGirl.create(:user)
  }

  let!(:destination) {
    FactoryGirl.create(:destination)
  }

  let!(:reviews) {
    15.times do |i|
      destination.reviews.create!(
        content: Faker::HitchhikersGuideToTheGalaxy.quote,
        heading: Faker::HitchhikersGuideToTheGalaxy.specie,
        rating: Faker::Number.between(1, 5),
        user_id: user.id
      )
    end
  }

  before { get "/v1/destinations/#{destination.id}/reviews"}

  it 'returns all reviews' do
    expect(JSON.parse(response.body).size).to eq(15)
  end

  it 'returns status code 200' do
    review = destination.reviews.first
    get "/v1/destinations/#{destination.id}/reviews/#{review.id}"
    expect(response).to have_http_status(:success)
  end
end
