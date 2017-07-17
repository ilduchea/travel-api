require 'rails_helper'

describe "get all destinations route", :type => :request do
  let!(:destinations) { FactoryGirl.create_list(:destination, 20)}
  before { get '/destinations'}

  it 'returns all destinations' do
    expect(JSON.parse(response.body).size).to eq(20)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns status code of 404 when not found' do
    get '/destinations/00'
    expect(response).to have_http_status(404)
  end

  it 'should return 200 for specific destination' do
    destination1 = destinations.first
    get "/destinations/#{destination1.id}"
    expect(response).to have_http_status(200)
  end
end
