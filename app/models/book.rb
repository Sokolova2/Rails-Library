class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :title, type: String
  field :descriptions, type: String
  field :author, type: String
  field :status, type: String, default: 'Open'
  field :borrowed_by, type: String
end
