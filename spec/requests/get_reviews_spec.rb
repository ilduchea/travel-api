require 'rails_helper'

describe "get all reviews route", :type => :request do

  before do
    @destination = FactoryGirl.create(:destination)
    user = FactoryGirl.create(:user)
    @reviews = 15.times do |i|
      @destination.reviews.create!(
        content: Faker::HitchhikersGuideToTheGalaxy.quote,
        heading: Faker::HitchhikersGuideToTheGalaxy.specie,
        rating: Faker::Number.between(1, 5),
        user_id: user.id
      )
    end

    post '/v1/auth_user', params: {
      email: user.email,
      password: user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]
  end

  it 'returns all reviews' do
    get "/v1/destinations/#{@destination.id}/reviews?api_key=#{@user_api_key}"
    expect(JSON.parse(response.body).size).to eq(15)
  end

  it 'returns status code 200' do
    review = @destination.reviews.first
    get "/v1/destinations/#{@destination.id}/reviews/#{review.id}?api_key=#{@user_api_key}"
    expect(response).to have_http_status(:success)
  end
end
