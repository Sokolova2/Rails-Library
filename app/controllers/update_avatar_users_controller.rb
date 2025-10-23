# frozen_string_literal: true

class UpdateAvatarUsersController < ApplicationController
  before_action :authenticate_user!

  def choose_avatar
    @user = current_user
    @avatars = UpdateUserAvatarService::AVATARS
  end

  def update_avatar_users
    @user = current_user

    if UpdateUserAvatarService.new(@user, params).set_user_avatar
      redirect_to edit_user_registration_path
    else
      redirect_to choose_avatar_path
    end
  end
end
