# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def authenticate_admin!
    authenticate_user!
    return if current_user.admin

    redirect_to root_path, alert: 'Access denied!'
  end
end
