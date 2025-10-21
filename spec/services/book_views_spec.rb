# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookViewsService, type: :service do
  let(:user) { create :user }
  let(:book) { create(:book) }
  let(:session) { {} }

  describe '#track'  do
    subject(:service) { described_class.new(user, book, session) }

    context 'when add impression for views' do
      it 'increment views by one session' do
        expect do
          service.track
        end.to change(Impression, :count).by(1)
                                         .and change { book.reload.views }.by(1)
      end
    end

    context 'when already impression exist' do
      subject(:impression) { create(:impression, user: user, book: book) }

      it 'not increment views' do
        subject
        expect { service.track }.to change { book.reload.views }.by(0)
      end
    end
  end
end
