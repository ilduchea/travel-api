class Destination < ApplicationRecord
  has_many :reviews
  # before_action :authorize, except: [:index, :show]
  validates :name, :city, :country, :presence => true
  include Filterable
  paginates_per 20

  scope :city_scope, -> (city){ where("lower(city) like ?", "%#{city}%".downcase) }
  scope :country_scope, -> (country){ where("lower(country) like ?", "%#{country}%".downcase) }
  scope :name_scope, -> (name){ where("lower(name) like ?", "%#{name}%".downcase) }
  scope :locale_scope, -> (locale){ where("lower(locale) like ?", "%#{locale}%".downcase) }
  scope :mostReviews, -> (limit){(
    select("destinations.*, count(reviews.id) as reviews_count")
      .joins(:reviews)
      .group("destinations.id")
      .order("reviews_count DESC")
      .limit(limit)
    )
  }
  scope :random, ->(limit){  Destination.order("RANDOM()").limit(limit) }
end
