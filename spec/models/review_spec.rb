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

end
