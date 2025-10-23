# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateBookStatuses', type: :request do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  before do
    login_as(user)
  end

  describe 'PATCH /update' do
    subject(:update_status) { put book_update_status_path(book) }

    it 'updates book status' do
      subject
      expect { book.reload.status }.to change(book, :status)
    end
  end
end
