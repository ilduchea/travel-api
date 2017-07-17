require 'rails_helper'

describe 'destinations#destroy', :type => :request do

  it 'deletes the destination' do
    destination = FactoryGirl.create(:destination)
    delete "/destinations/#{destination.id}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)['message']).to eq("Your destination has been deleted.")
  end

  it 'responds with 404' do
    destination = FactoryGirl.create(:destination)
    destination.destroy
    get "/destinations/#{destination.id}"
    expect(response).to have_http_status(404)
  end
end
