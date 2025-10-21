# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateBookStatusService, type: :service do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe '#update_book_status' do
    context 'when book status is open' do
      subject(:service) { described_class.new(book, user) }
      let!(:history) { create(:history, book: book, user: user) }
      let!(:message) { create(:message, user: user) }

      it 'change book status to close' do
        service.update_book_status

        expect(book.status).to eq('Closed')
        expect(book.user).to eq(user)
      end

      it 'create history about took book' do
        service.update_book_status

        expect(history.book).to eq(book)
        expect(history.user).to eq(user)
        expect(history.status).to eq('took')
      end

      it 'send message to user from book favorite' do
        service.update_book_status

        expect(message.user).to eq(user)
        expect(message.read).to eq(false)
        expect(message.content).not_to eq(nil)
      end
    end

    context 'when book status is close' do
      subject(:service) { described_class.new(book, user) }
      let!(:history) { create(:history, book: book, user: user) }
      let!(:message) { create(:message, user: user) }

      before do
        book.update(status: 'Closed')
        history.update(status: 'return')
        message.update(read: true, content: 'Book open')
      end

      it 'change book status to open' do
        service.update_book_status

        expect(book.status).to eq('Open')
        expect(book.user).to eq(nil)
      end

      it 'create history about return book' do
        service.update_book_status

        expect(history.book).to eq(book)
        expect(history.user).to eq(user)
        expect(history.status).to eq('return')
      end

      it 'send message to user from book favorite' do
        service.update_book_status

        expect(message.user).to eq(user)
        expect(message.read).to eq(true)
        expect(message.content).not_to eq(nil)
      end
    end
  end
end
