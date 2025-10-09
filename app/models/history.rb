class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :book_id, type: Integer
  field :status, type: String
end
