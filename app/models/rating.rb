# frozen_string_literal: true

class Rating
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, type: Integer

  belongs_to :user
  belongs_to :book

  validates :score, presence: true
  validates :user_id, uniqueness: { scope: :book_id }
end
