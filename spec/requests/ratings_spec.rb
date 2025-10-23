# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    login_as(user, scope: :user)
  end

  describe 'POST /create' do
    context 'with valid params' do
      subject(:create_rating) { create(:rating, user: user, book: book) }

      it 'creates a new rating' do
        expect { create_rating }.to change(Rating, :count).by(1)
      end
    end

    context 'with invalid params' do
      subject(:create_rating) { create(:rating, user: user, book: book) }

      it 'does not create a new rating' do
        subject
        expect { create_rating }.to change(Rating, :count).by(0)
      end
    end
  end
end
