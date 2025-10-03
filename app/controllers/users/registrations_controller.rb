# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create]
  before_action :configure_account_update_params, only: %i[update]

  def choose_avatar
    @avatars = {
      male: Rails.root.glob('app/assets/images/male/*.png'),
      female: Rails.root.glob('app/assets/images/female/*.png'),
      animal: Rails.root.glob('app/assets/images/animal/*.png')
    }

    if params[:avatar].present?
      gender = params[:avatar].split('/').first

      filename = File.basename(params[:avatar])

      file_path = Rails.root.join("app/assets/images/#{gender}/#{filename}")

      if current_user.update(avatar: File.open(file_path))
        redirect_to edit_user_registration_path
      else
        redirect_to choose_avatar_path
      end
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[login avatar gender language])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[login avatar gender language])
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def update_resource(resource, params)
    if resource.encrypted_password.blank?
      resource.update_without_password(account_update_params.except(:current_password))
    end

    if params[:password].present? && params[:password_confirmation].present?
      resource.update_with_password(account_update_params)
    else
      resource.update_without_password(account_update_params.except(:current_password))
    end
  end
end
