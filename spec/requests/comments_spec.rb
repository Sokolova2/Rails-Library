# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST /create' do
    subject(:create_comment) { post book_comments_path(book), params: valid_params }

    let(:valid_params) { { content: 'test comment' } }

    context 'when authorize' do
      before { login_as(user, scope: :user) }

      it 'creates comment successfully' do
        expect { create_comment }.to change(Comment, :count).by(1).and change {
          response
        }.to redirect_to(book_path(book))
      end
    end

    context 'when not authorize' do
      it 'does not creates comment successfully' do
        expect { create_comment }.not_to(change(Comment, :count))
      end

      context 'when does not creating comment' do
        before { create_comment }

        it 'redirects to sign in page' do
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
