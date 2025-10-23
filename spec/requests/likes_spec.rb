# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'POST /create' do
    subject(:create_like) { post book_likes_path(book) }

    context 'when authorize' do
      before { login_as(user, scope: :user) }

      it 'creates like' do
        expect { create_like }.to change(Like, :count).by(1).and change { response }.to redirect_to(book_path(book))
      end
    end

    context 'when not authorize' do
      before { create_like }

      it 'redirects to log in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_like) { delete book_like_path(book, like) }

    let!(:like) { create(:like, user: user, book: book) }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
      end

      it 'destroys like' do
        expect { destroy_like }.to change(Like, :count).by(-1).and change { response }.to redirect_to(book_path(book))
      end
    end

    context 'when not authorize' do
      before { destroy_like }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
