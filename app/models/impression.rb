# frozen_string_literal: true

class Impression
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :book
  belongs_to :user, optional: true
end
