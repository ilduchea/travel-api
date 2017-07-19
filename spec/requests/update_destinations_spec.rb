require 'rails_helper'

describe "updates a destination route", :type => :request do

  before do
    @destination = FactoryGirl.create(:destination)
    user = FactoryGirl.create(:user)
    post '/v1/auth_user', params: {
      email: user.email,
      password: user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]
    put "/v1/destinations/#{@destination.id}", params: {
      name: "Kat's Place",
      api_key: @user_api_key
    }
  end

  it 'returns the destination name' do
    expect(JSON.parse(response.body)['message']).to eq("Your destination has successfully been updated.")
  end

end
