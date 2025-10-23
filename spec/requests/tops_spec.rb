# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tops', type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    subject(:get_index) { get tops_path }

    before { get_index }

    it 'returns status success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 200' do
      expect(response.status).to eq 200
    end
  end
end
