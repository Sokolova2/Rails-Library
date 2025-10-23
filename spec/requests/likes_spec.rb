# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    login_as(user, scope: :user)
  end

  describe 'POST /create' do
    subject(:create_like) { create(:like, user: user, book: book) }

    it 'create like' do
      expect { create_like }.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    let!(:like) { create(:like, user: user, book: book) }
    subject(:destroy_like) { delete book_like_path(book, like) }

    it 'destroy like' do
      expect { destroy_like }.to change(Like, :count).by(-1)
      expect(response).to redirect_to(book_path(book))
    end
  end
end
