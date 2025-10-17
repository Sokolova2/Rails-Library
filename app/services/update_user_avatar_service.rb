# frozen_string_literal: true

class UpdateUserAvatarService
  def initialize(user)
    @user = user
  end

  def set_avatar_user
    # TODO:  move to constants
    @avatars = {
      male: Rails.root.glob('app/assets/images/male/*.png'),
      female: Rails.root.glob('app/assets/images/female/*.png'),
      animal: Rails.root.glob('app/assets/images/animal/*.png')
    }

    set_random_avatar
  end

  def set_random_avatar
    if avatar_param_present?
      handle_avatar
    elsif user_avatar_param_present?
      current_user.update(avatar: params[:user][:avatar])
      redirect_to edit_user_registration_path
    end
  end

  def avatar_param_present?
    params[:avatar].present?
  end

  def user_avatar_param_present?
    params[:user].present? && params[:user][:avatar].present?
  end

  def handle_avatar
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
