require 'rails_helper'

describe "updates a destination route", :type => :request do

  before do
    @destination = FactoryGirl.create(:destination)
    put "/destinations/#{@destination.id}", params: {
      name: "Kat's Place"
    }
  end

  it 'returns the destination name' do
    expect(JSON.parse(response.body)['message']).to eq("Your destination has successfully been updated.")
  end

end
