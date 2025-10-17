# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  belongs_to :user
  belongs_to :book

  validates :content, length: { minimum: 1 }
end
