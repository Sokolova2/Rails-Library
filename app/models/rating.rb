class Rating
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, :type => Integer

  belongs_to :user
  belongs_to :book
end
