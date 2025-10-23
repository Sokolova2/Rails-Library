# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tops', type: :request do
  let(:user) { create(:user) }
  let!(:book1) { create(:book, views: 10) }
  let!(:book2) { create(:book, views: 5) }
  let!(:book3) { create(:book, views: 1) }

  before do
    login_as(user, scope: :user)

    create_list(:like, 10, book: book1)
    create_list(:like, 5, book: book2)
    create_list(:like, 1, book: book3)
  end

  describe 'GET /index' do
    subject(:get_index) { get tops_path }

    it 'return sorted books' do
      subject

      expect(response).to have_http_status(:success)

      expect(response.body.index(book1.title)).to be < response.body.index(book2.title)
      expect(response.body.index(book2.title)).to be < response.body.index(book3.title)
    end
  end
end
