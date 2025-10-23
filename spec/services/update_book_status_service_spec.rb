# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateBookStatusService, type: :service do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  before do
    create(:favorite, user: user, book: book)
  end

  describe '#update_book_status' do
    subject(:service) { described_class.new(book, user) }

    context 'when book status is open' do
      it 'changes book status to close' do
        expect { service.update_book_status }.to change(book, :status).to('Closed')
      end

      it 'adds user to borrower' do
        expect { service.update_book_status }.to change(book, :user).from(nil).to(user)
      end

      it 'creates history for borrowed book' do
        expect { service.update_book_status }.to change(History, :count).by(1)
      end

      context 'when creating history' do
        before { service.update_book_status }

        it 'history book equals specific book' do
          expect(History.last.book).to eq(book)
        end

        it 'history book equals specific user' do
          expect(History.last.user).to eq(user)
        end

        it 'history status equals took' do
          expect(History.last.status).to eq('took')
        end
      end

      it 'adds notifies user' do
        expect { service.update_book_status }.to change(Message, :count).by(1)
      end

      context 'when creating message' do
        before { service.update_book_status }

        it 'message user equals specific user' do
          expect(Message.last.user).to eq(user)
        end

        it 'message read status equals false' do
          expect(Message.last.read).to be_falsey
        end

        it 'message content not equals nil' do
          expect(Message.last.content).not_to be_nil
        end
      end
    end

    context 'when book status is close' do
      let!(:history) { create(:history, user: user, book: book) }

      before do
        book.update(status: 'Closed', user: user)
      end

      it 'changes book status to open' do
        expect { service.update_book_status }.to change(book, :status).to('Open')
      end

      it 'changes book user to nil' do
        expect { service.update_book_status }.to change(book, :user).to(nil)
      end

      it 'changes history for return book' do
        expect { service.update_book_status }.to change { history.reload.status }.to eq('return')
      end

      it 'adds notifies user' do
        expect { service.update_book_status }.to change(Message, :count).by(1)
      end

      context 'when creating message' do
        before { service.update_book_status }

        it 'message user equals specific user' do
          expect(Message.last.user).to eq(user)
        end

        it 'message content not equals nil' do
          expect(Message.last.content).not_to be_nil
        end
      end
    end
  end
end
