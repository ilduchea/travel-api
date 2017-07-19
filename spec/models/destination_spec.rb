require 'rails_helper'

RSpec.describe Destination, type: :model do
  it { should have_many :reviews }

  it { should validate_presence_of :name }
  it { should validate_presence_of :city }
  it { should validate_presence_of :country }

  describe "scopes", type: :request do

    before do
      @destination2 = FactoryGirl.create(:destination)
      @destination1 = FactoryGirl.create(:destination)
      @user = FactoryGirl.create(:user)
      post '/v1/auth_user', params: {
        email: @user.email,
        password: @user.password
      }
      @user_api_key = JSON.parse(response.body)["auth_token"]
    end

    describe "name_scope" do
      it "returns all destinations where search params equals the name" do
        get "/v1/destinations?name_scope=#{@destination1.name}&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).first['name']).to eq(@destination1.name)
      end
    end

    describe "city_scope" do
      it "returns the all destinations where search params equal the city" do
        get "/v1/destinations?city_scope=#{@destination1.city}&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).first['city']).to eq(@destination1.city)
      end
    end

    describe "locale_scope" do
      it "returns all destinations where search params equals the locale" do
        get "/v1/destinations?locale_scope=#{@destination1.locale}&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).first['locale']).to eq(@destination1.locale)
      end
    end

    describe "country_scope" do
      it "returns all destinations where search params equals the country" do
        get "/v1/destinations?country_scope=#{@destination1.country}&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).first['country']).to eq(@destination1.country)
      end
    end

    describe "mostReviews" do
      it "returns the most reviewed destination" do
        user = FactoryGirl.create(:user)
        @destination2.reviews.create(
          content: Faker::HitchhikersGuideToTheGalaxy.quote,
          heading: Faker::HitchhikersGuideToTheGalaxy.specie,
          rating: Faker::Number.between(1, 5),
          user_id: user.id
        )
        get "/v1/destinations?mostReviews=1&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).first['id']).to eq(@destination2.id)
      end
    end

    describe 'random' do
      it "returns a random destination" do
        get "/v1/destinations?random=1&api_key=#{@user_api_key}"
        expect(JSON.parse(response.body).length).to eq(1)
      end
    end
  end

end
