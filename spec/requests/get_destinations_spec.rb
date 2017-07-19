require 'rails_helper'

describe "get all destinations route", :type => :request do
  let!(:destinations) { FactoryGirl.create_list(:destination, 20)}
  before do
    user = FactoryGirl.create(:user)
    post '/v1/auth_user', params: {
      email: user.email,
      password: user.password
    }
    @user_api_key = JSON.parse(response.body)["auth_token"]
    get "/v1/destinations?api_key=#{@user_api_key}"
  end

  it 'returns all destinations' do
    expect(JSON.parse(response.body).size).to eq(20)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns status code of 404 when not found' do
    get "/v1/destinations/00?api_key=#{@user_api_key}"
    expect(response).to have_http_status(404)
  end

  it 'should return 200 for specific destination' do
    destination1 = destinations.first
    get "/v1/destinations/#{destination1.id}?api_key=#{@user_api_key}"
    expect(response).to have_http_status(200)
  end
end
