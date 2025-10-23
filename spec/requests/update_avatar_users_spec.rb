# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateAvatarUsers', type: :request do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /choose_avatar' do
    subject(:get_choose_avatar) { get choose_avatar_path }

    it 'get all avatars' do
      subject
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user.avatar.url)
    end
  end

  describe 'PATCH /update_avatar_users' do
    context 'when update avatar successfully' do
      subject(:put_update_avatar_users) { put update_avatar_users_path, params: { user: { avatar: Rails.root.join('app/assets/images/female/avatar1.png').open } } }

      it 'update avatar successfully' do
        old_avatar = user.avatar.url
        subject
        expect(response).to redirect_to(edit_user_registration_path)
        expect(user.reload.avatar).not_to eq(old_avatar)
      end
    end

    context 'when update avatar unsuccessfully' do
      subject(:put_update_avatar_users) { put update_avatar_users_path, params: { user: { avatar: nil } } }

      it 'update avatar unsuccessfully' do
        subject
        expect(response).to redirect_to(choose_avatar_path)
      end
    end
  end
end
