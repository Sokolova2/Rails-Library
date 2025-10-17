# frozen_string_literal: true

class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: { scope: :book_id }
end
