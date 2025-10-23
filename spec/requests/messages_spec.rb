# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    create_list(:message, 3, user: user, read: false)
  end

  describe 'GET /index' do
    subject(:get_index) { get messages_path }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
        get_index
      end

      it 'gets status is success' do
        expect(response).to have_http_status(:ok)
      end

      it 'gets all messages' do
        user.messages.each do |message|
          expect(response.body).to include(message.content)
        end
      end

      it 'changes status to read' do
        user.messages.each do |message|
          expect(message.reload.read).to be true
        end
      end
    end

    context 'when not authorize' do
      before { get_index }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_messages) { delete messages_path }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
      end

      it 'destroy all messages' do
        expect { destroy_messages }.to change(Message, :count).by(-3).and change {
          response
        }.to redirect_to(messages_path)
      end
    end

    context 'when not authorize' do
      before do
        destroy_messages
      end

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
