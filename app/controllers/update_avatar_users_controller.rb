# frozen_string_literal: true

class UpdateAvatarUsersController < ApplicationController
  def choose_avatar
    @user = current_user

    set_avatar_user

    if params[:avatar].present?
      handle_avatar
    elsif params[:user].present? && params[:user][:avatar].present?
      current_user.update(avatar: params[:user][:avatar])
      redirect_to edit_user_registration_path
    end
  end

  private

  def set_avatar_user
    @avatars = {
      male: Rails.root.glob('app/assets/images/male/*.png'),
      female: Rails.root.glob('app/assets/images/female/*.png'),
      animal: Rails.root.glob('app/assets/images/animal/*.png')
    }
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
