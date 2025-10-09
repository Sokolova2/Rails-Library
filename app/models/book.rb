class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :title, type: String
  field :descriptions, type: String
  field :author, type: String
  field :status

  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :ratings, dependent: :destroy
end
