# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[index destroy]

  def index
    @messages = current_user.messages.order(created_at: :desc)

    current_user.messages.where(read: false).update_all(read: true)
  end

  def destroy
    current_user.messages.delete_all

    redirect_to messages_path
  end

  private

  def set_message
    @messages = current_user.messages.order(created_at: :desc)
  end
end
