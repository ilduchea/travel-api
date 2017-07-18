require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :user }
  it { should belong_to :destination }

  it { should validate_presence_of :content }
  it { should validate_presence_of :heading }
  it { should validate_presence_of :rating }
  it { should validate_numericality_of(:rating)
    .is_greater_than_or_equal_to(1)
    .is_less_than_or_equal_to(5) }

  describe "scopes", type: :request do
    before do
      @destination = FactoryGirl.create(:destination)
      @user = FactoryGirl.create(:user)
      @review1 = @destination.reviews.create(
        content: "test test's ??? why this's working's now's && is trouble",
        heading: Faker::HitchhikersGuideToTheGalaxy.specie,
        rating: Faker::Number.between(1, 5),
        user_id: @user.id
      )
      @review2 = @destination.reviews.create(
        content: Faker::HitchhikersGuideToTheGalaxy.quote,
        heading: Faker::HitchhikersGuideToTheGalaxy.specie,
        rating: Faker::Number.between(1, 5),
        user_id: @user.id
      )
    end

    describe "heading_scope" do
      it "returns all reviews where search params equals the heading" do
        get "/v1/destinations/#{@destination.id}/reviews?heading_scope=#{@review1.heading}"
        expect(JSON.parse(response.body).first['heading']).to eq(@review1.heading)
      end
    end

    describe "content_scope" do
      it "returns the all reviews where search params equal the content" do
        # search_content = @review1.content.split(' ')[0]
        search_content = @review1.content
        get "/v1/destinations/#{@destination.id}/reviews?content_scope=#{search_content}"
        expect(JSON.parse(response.body).first['content']).to include(search_content)
      end
    end

    describe "rating_scope" do
      it "returns all reviews where search params equals the rating" do
        get "/v1/destinations/#{@destination.id}/reviews?rating_scope=#{@review1.rating}"
        expect(JSON.parse(response.body).first['rating']).to eq(@review1.rating)
      end
    end
  end
end
