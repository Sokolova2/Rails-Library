# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateBookStatuses', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'PATCH /update' do
    subject(:update_status) { put book_update_status_path(book) }

    before { update_status }

    context 'when user authorize' do
      before { login_as(user) }

      it 'updates book status' do
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is not authorize' do
      it 'updates book status' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
