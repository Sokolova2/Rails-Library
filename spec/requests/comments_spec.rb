# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create :user }
  let(:book) { create :book }

  before do
    login_as(user, scope: :user)
  end

  describe 'POST /create' do
    let(:valid_params) { { comment: attributes_for(:comment) } }

    # TODO: test call to action, not factory create
    subject(:create_comment) { create(:comment, user_id: user.id, book_id: book.id) }

    it 'create comment successfully' do
      expect { create_comment }.to change { Comment.count }.by(1)
    end
  end
end
