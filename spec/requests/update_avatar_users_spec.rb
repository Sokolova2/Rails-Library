# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateAvatarUsers', type: :request do
  let(:user) { create(:user) }

  describe 'GET /choose_avatar' do
    subject(:get_choose_avatar) { get choose_avatar_path }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
        get_choose_avatar
      end

      it 'gets all avatars' do
        expect(response.body).to include(user.avatar.url)
      end

      it 'gets status code is success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not authorize' do
      before { get_choose_avatar }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /update_avatar_users' do
    context 'when update avatar successfully' do
      subject(:put_update_avatar_users) do
        put update_avatar_users_path,
            params: { user: { avatar: Rails.root.join('app/assets/images/female/avatar1.png').open } }
      end

      before do
        login_as(user, scope: :user)
        put_update_avatar_users
      end

      let(:old_avatar) { user.avatar.url }

      it 'update avatar successfully' do
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'user avatar not equals old avatar' do
        expect(user.reload.avatar).not_to eq(old_avatar)
      end
    end

    context 'when update avatar unsuccessfully' do
      subject(:put_update_avatar_users) { put update_avatar_users_path, params: { user: { avatar: nil } } }

      before do
        login_as(user, scope: :user)
        put_update_avatar_users
      end

      it 'update avatar unsuccessfully' do
        expect(response).to redirect_to(choose_avatar_path)
      end
    end
  end
end
