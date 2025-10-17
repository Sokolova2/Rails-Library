# frozen_string_literal: true

class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :title, type: String
  field :descriptions, type: String
  field :author, type: String
  field :status, type: String, default: 'Open'
  field :genre, type: String
  field :views, type: Integer, default: 0

  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :impressions, dependent: :destroy

  validates :title, presence: true
  validates :descriptions, presence: true
  validates :author, presence: true
  validates :image, presence: true

  def self.search(search)
    SearchService.new(self).search(search)
  end
end
