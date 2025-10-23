# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'GET /index' do
    subject(:get_index) { get root_path }

    context 'when authorize' do
      before do
        login_as(user, scope: :user)
        create(:impression, user: user)
      end

      it 'returns all books and remove impressions' do
        expect { get_index }.to change(Impression, :count).by(-1).and change { response }.to have_http_status(:success)
      end
    end

    context 'when not authorize' do
      context 'when return all book' do
        before { get_index }

        it 'returns the all books' do
          expect(response).to have_http_status(:success)
        end
      end

      it 'does not remove impressions' do
        expect { get_index }.not_to change(Impression, :count)
      end
    end
  end
end
