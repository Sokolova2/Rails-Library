# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateUserAvatarService, type: :service do
  let(:user) { create(:user) }

  describe '#set_user_avatar' do
    subject(:service) { described_class.new(user, params) }

    context 'when user pick avatar' do
      let(:params) { { avatar: 'female/avatar2.png' } }

      before do
        user.update(avatar: Rails.root.join('app/assets/images/female/avatar1.png').open)
      end

      it 'change user avatar to service avatar' do
        expect { service.set_user_avatar }.to change { user.reload.avatar.filename.to_s }.to eq('avatar2.png')
      end
    end

    context 'when user upload avatar' do
      let(:params) do
        { user: { avatar: fixture_file_upload('avatar.png', 'image/png') } }
      end

      it 'change user avatar to upload avatar' do
        expect { service.set_user_avatar }.to change { user.avatar.filename.to_s }.to eq('avatar.png')
      end
    end
  end
end
