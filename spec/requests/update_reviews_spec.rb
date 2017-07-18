require 'rails_helper'

describe "updates a review route", :type => :request do

  before do
    @user = FactoryGirl.create(:user)
    @destination = FactoryGirl.create(:destination)
    @review = FactoryGirl.build(:review)
    @review.destination_id = @destination.id
    @review.user_id = @user.id
    @review.save
    put "/v1/destinations/#{@destination.id}/reviews/#{@review.id}", params: {
      content: "Kat's Place"
    }
  end

  it 'returns the destination name' do
    expect(JSON.parse(response.body)['message']).to eq("Your review has successfully been updated.")
  end

end
