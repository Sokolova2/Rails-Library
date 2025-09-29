class User
  include Mongoid::Document

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
      user.login = auth.info.login
      # user.avatar = auth.info.image
      user.language = I18n.default_locale
    end
  end

  field :login

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :uid
  field :provider

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  field :language

  include Mongoid::Timestamps
end
