class Review < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  # before_action :authorize, except: [:index, :show]
  validates :content, :heading, :rating, :presence => true
  validates_numericality_of :rating, greater_than_or_equal_to: 1
  validates_numericality_of :rating, less_than_or_equal_to: 5
end
