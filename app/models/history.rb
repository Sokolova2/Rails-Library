class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String

  belongs_to :book
  belongs_to :user
end
