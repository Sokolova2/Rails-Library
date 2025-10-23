# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookViewsService, type: :service do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:session) { {} }

  describe '#track'  do
    subject(:service) { described_class.new(user, book, session) }

    context 'when adding impression for views' do
      it 'creates an impression' do
        expect { service.track }.to change(Impression, :count).by(1)
      end

      it 'creates increment book views by 1' do
        expect { service.track }.to change { book.reload.views }.by(1)
      end
    end

    context 'when impression already exist' do
      subject(:impression) { create(:impression, user: user, book: book) }

      before { impression }

      it 'does not increment views' do
        expect { service.track }.not_to change(book.reload, :views)
      end
    end
  end
end
