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
    end

    describe "name_scope" do
      it "returns all destinations where search params equals the name" do
        get "/destinations?name_scope=#{@destination1.name}"
        expect(JSON.parse(response.body).first['name']).to eq(@destination1.name)
      end
    end

    describe "city_scope" do
      it "returns the all destinations where search params equal the city" do
        get "/destinations?city_scope=#{@destination1.city}"
        expect(JSON.parse(response.body).first['city']).to eq(@destination1.city)
      end
    end

    describe "locale_scope" do
      it "returns all destinations where search params equals the locale" do
        get "/destinations?locale_scope=#{@destination1.locale}"
        expect(JSON.parse(response.body).first['locale']).to eq(@destination1.locale)
      end
    end

    describe "country_scope" do
      it "returns all destinations where search params equals the country" do
        get "/destinations?country_scope=#{@destination1.country}"
        expect(JSON.parse(response.body).first['country']).to eq(@destination1.country)
      end
    end
  end

end
