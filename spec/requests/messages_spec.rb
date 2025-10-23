# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create :user }
  let(:book) { create :book }
  let!(:messages) { create_list :message, 3, user: user, read: false }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    subject(:get_index) { get messages_path }

    it 'get all messages' do
      get_index
      expect(response).to have_http_status(:ok)

      messages.each do |message|
        expect(response.body).to include(message.content)
      end

      messages.each do |message|
        expect(message.reload.read).to be true
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_messages) { delete message_path(messages) }

    it 'destroy all messages' do
      expect { destroy_messages }.to change(Message, :count).by(-3)
    end
  end
end
