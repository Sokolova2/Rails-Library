# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:valid_params) { { score: 5 } }

  describe 'POST /create' do
    context 'when authorize' do
      subject(:create_rating) { post book_ratings_path(book), params: valid_params }

      before { login_as(user, scope: :user) }

      it 'creates a rating' do
        expect { create_rating }.to change(Rating, :count).by(1).and change { response }.to have_http_status(:redirect)
      end
    end

    context 'when not authorize' do
      subject(:create_rating) { post book_ratings_path(book), params: valid_params }

      it 'does not creates a rating' do
        expect { create_rating }.not_to change(Rating, :count)
      end

      context 'when does not creating a rating' do
        before { create_rating }

        it 'redirects to log in' do
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
