# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'GET /show' do
    subject(:get_show) { get favorites_path }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
        get_show
      end

      it 'get all favorites' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not authorize' do
      before { get_show }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /create' do
    subject(:create_favorite) { post book_favorites_path(book) }

    context 'when authorize' do
      before { login_as(user, scope: :user) }

      it 'create favorite' do
        expect { create_favorite }.to change(Favorite, :count).by(1)
      end
    end

    context 'when not authorize' do
      before { create_favorite }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_favorite) { delete book_favorites_path(book), params: { book_id: book.id } }

    let!(:favorite) { create(:favorite, user: user, book: book) }

    context 'when authorize' do
      before { login_as(user, scope: :user) }

      it 'destroy favorite' do
        expect { delete_favorite }.to change(Favorite, :count).by(-1)
      end
    end

    context 'when not authorize' do
      before { delete_favorite }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
