class Review < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  include Filterable
  # before_action :authorize, except: [:index, :show]
  validates :content, :heading, :rating, :presence => true
  validates_numericality_of :rating, greater_than_or_equal_to: 1
  validates_numericality_of :rating, less_than_or_equal_to: 5

  #Scopes
  scope :heading_scope, -> (heading){ where("lower(heading) like ?", "%#{heading}%".downcase) }
  scope :content_scope, -> (content){ where("lower(content) like ?", "%#{content}%".downcase) }
  scope :rating_scope, -> (rating){ where(rating: rating) }
end
