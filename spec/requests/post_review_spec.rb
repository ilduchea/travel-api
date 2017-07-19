require 'rails_helper'

describe "post a review route", :type => :request do

  before do
    destination = FactoryGirl.create(:destination)

    user = FactoryGirl.create(:user)
    post '/v1/auth_user', params: {
      email: user.email,
      password: user.password
    }
    user_api_key = JSON.parse(response.body)["auth_token"]

    post "/v1/destinations/#{destination.id}/reviews", params: {
      content: 'Nice',
      heading: 'Cool',
      rating: 4,
      user_id: user.id,
      api_key: user_api_key
      }

  end

  it 'returns the review content' do
    expect(JSON.parse(response.body)['content']).to eq('Nice')
  end

  it 'returns the review heading' do
    expect(JSON.parse(response.body)['heading']).to eq('Cool')
  end

  it 'returns the review rating' do
    expect(JSON.parse(response.body)['rating']).to eq(4)
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end
