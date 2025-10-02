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
      user.avatar = auth.info.image
      user.gender = auth.info.gender
      user.language = I18n.default_locale
    end
  end

  def set_random_avatar
    return if avatar.present?

    gender = self.gender == 'female' ? 'female' : 'male'
    avatar = Dir.glob(Rails.root.join('app', 'assets', 'images', gender, '*.png'))

    random_avatar = avatar.sample
    self.avatar = File.open(random_avatar)
    self.avatar_filename = File.basename(random_avatar)

    if self.gender == nil
      avatar = Dir.glob(Rails.root.join('app', 'assets', 'images', 'animal', '*.png'))

      random_avatar = avatar.sample
      self.avatar = File.open(random_avatar)
      self.avatar_filename = File.basename(random_avatar)
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

  include Mongoid::Timestamps
end
