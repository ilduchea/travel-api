class Destination < ApplicationRecord
  has_many :reviews
  # before_action :authorize, except: [:index, :show]
  validates :name, :city, :country, :presence => true
end
