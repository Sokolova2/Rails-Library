class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :title, type: String
  field :descriptions, type: String
  field :author, type: String
  field :status
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
end
