require 'rails_helper'

describe 'destinations#destroy', :type => :request do

  before do
    @destination = FactoryGirl.create(:destination)
    user = FactoryGirl.create(:user)
    post '/v1/auth_user', params: {
      email: user.email,
      password: user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]
  end

  it 'deletes the destination' do
    delete "/v1/destinations/#{@destination.id}?api_key=#{@user_api_key}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)['message']).to eq("Your destination has been deleted.")
  end

  it 'responds with 404' do
    @destination.destroy
    get "/v1/destinations/#{@destination.id}?api_key=#{@user_api_key}"
    expect(response).to have_http_status(404)
  end
end
