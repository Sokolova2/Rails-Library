# frozen_string_literal: true

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :read, type: Boolean, default: false

  belongs_to :user
end
