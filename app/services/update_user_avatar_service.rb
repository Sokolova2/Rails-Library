# frozen_string_literal: true

class UpdateUserAvatarService
  AVATARS = {
    male: Rails.root.glob('app/assets/images/male/*.png'),
    female: Rails.root.glob('app/assets/images/female/*.png'),
    animal: Rails.root.glob('app/assets/images/animal/*.png')
  }.freeze

  def initialize(user, params)
    @user = user
    @params = params
  end

  def set_user_avatar
    if avatar_param_present?
      handle_avatar
    elsif user_avatar_param_present?
      @user.update(avatar: @params[:user][:avatar])
    end
  end

  private

  def avatar_param_present?
    @params[:avatar].present?
  end

  def user_avatar_param_present?
    @params[:user].present? && @params[:user][:avatar].present?
  end

  def handle_avatar
    gender = @params[:avatar].split('/').first
    filename = File.basename(@params[:avatar])

    file_path = Rails.root.join("app/assets/images/#{gender}/#{filename}")

    @user.update(avatar: File.open(file_path))
  end
end
