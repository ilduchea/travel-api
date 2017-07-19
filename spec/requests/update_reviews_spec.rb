require 'rails_helper'

describe "updates a review route", :type => :request do

  before do
    @user = FactoryGirl.create(:user)
    @destination = FactoryGirl.create(:destination)
    @review = FactoryGirl.build(:review)
    @review.destination_id = @destination.id
    @review.user_id = @user.id
    @review.save
    post '/v1/auth_user', params: {
      email: @user.email,
      password: @user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]
    put "/v1/destinations/#{@destination.id}/reviews/#{@review.id}", params: {
      content: "Kat's Place",
      api_key: @user_api_key
    }
  end

  it 'returns the destination name' do
    expect(JSON.parse(response.body)['message']).to eq("Your review has successfully been updated.")
  end

end
