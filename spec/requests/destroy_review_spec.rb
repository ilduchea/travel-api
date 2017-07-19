require 'rails_helper'

describe 'reviews#destroy', :type => :request do
  before do
    @destination = FactoryGirl.create(:destination)
    @user = FactoryGirl.create(:user)
    @review = @destination.reviews.create(
      content: Faker::HitchhikersGuideToTheGalaxy.quote,
      heading: Faker::HitchhikersGuideToTheGalaxy.specie,
      rating: Faker::Number.between(1, 5),
      user_id: @user.id
    )
    post '/v1/auth_user', params: {
      email: @user.email,
      password: @user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]

    delete "/v1/destinations/#{@destination.id}/reviews/#{@review.id}?api_key=#{@user_api_key}"
  end

  it 'deletes the review' do
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)['message']).to eq("Your review has been deleted.")
  end


  it 'responds with 404' do
    get "/v1/destinations/#{@destination.id}/reviews/#{@review.id}?api_key=#{@user_api_key}"
    expect(response).to have_http_status(404)
  end
end
