# frozen_string_literal: true

class UpdateAvatarUsersController < ApplicationController
  def choose_avatar
    @user = current_user
    UpdateUserAvatarService.new(user: @user).set_avatar_user
  end
end
