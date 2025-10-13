# frozen_string_literal: true

class User
  include Mongoid::Document

  mount_uploader :avatar, AvatarUploader

  before_create :set_random_avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  class << self
    def from_omniauth(auth, lang = nil)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user_params(user, auth, lang)
      end
    end

    def user_params(user, auth, _lang)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.login = auth.info.email
      user.gender = auth.info.gender
      user.language = I18n.default_locale
    end
  end

  field :login

  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''
  field :uid
  field :provider

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  field :gender, type: String
  field :avatar, type: String
  field :language, type: String

  field :admin, type: Boolean, default: false
  include Mongoid::Timestamps

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :impressions, dependent: :destroy
  has_many :messages, dependent: :destroy

  private

  def set_random_avatar
    SetRandomAvatarService.new(self).set_random_avatar
  end
end
