# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let!(:favorite) { create(:favorite, user: user, book: book) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /show' do
    subject(:get_show) { get favorites_path }

    it 'get all favorites' do
      subject

      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe 'POST /create' do
    subject(:create_favorite) { create(:favorite, user: user, book: book) }

    it 'create favorite' do
      expect { create_favorite }.to change(Favorite, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_favorite) { delete favorites_path, params: { book_id: book.id } }

    it 'destroy favorite' do
      expect { delete_favorite }.to change(Favorite, :count).by(-1)
    end
  end
end
