# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:user) { create(:user) }
  let(:books) { create_list(:book, 10) }

  before do
    books.first.update(title: books.second.title)
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    context 'when search is blank' do
      subject(:get_index) { get books_path }

      before { get_index }

      it 'get all books' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when search is valid' do
      subject(:get_index) { get books_path, params: { genre: 'Adventure' } }

      it 'get all books with same title' do
        subject
        # TODO: one expect per it
        p response
        p response.body
        expect(response).to have_http_status(:success)
        expect(response.body).not_to include('Horror')
        expect(response.body).to include('Adventure')
      end
    end
  end

  describe 'GET /show' do
    subject(:get_show) { get book_path(books[0]) }

    it 'get show a page of a specific book' do
      expect { get_show }.to change { books[0].reload.views }.by(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    subject(:get_new) { get new_book_path }

    it 'get a new book page' do
      subject

      expect(response).to have_http_status(:success)
      # expect(response.status).to be :ok
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      subject(:create_book) { post books_path create(:book) }

      it 'create a new book success' do
        expect { create_book }.to change { Book.count }.by(1)
      end
    end

    context 'with invalid parameters' do
      subject(:create_book) { post books_path, params: { book: { title: 'we' } } }

      it 'not create a new book success' do
        expect { create_book }.to change { Book.count }.by(0)
        expect(response).to redirect_to(new_book_path)
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      subject(:update_book) { put book_path(books[0]), params: { book: { title: 'Nice book' } } }

      it 'update the book success' do
        subject
        expect(books[0].reload.title).to eq('Nice book')
      end
    end

    context 'with invalid parameters' do
      subject(:update_book) { put book_path(books[0]), params: { book: { title: 'The Whisper of Forgotten Stars Beneath the Endless Sky' } } }

      it 'not update the book success' do
        subject
        expect { :update_book }.not_to change(books[0], :title)
        expect(response).to redirect_to(book_path(books[0]))
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_book) { delete book_path(books[0]), params: { book: { id: books[0].id } } }

    it 'destroy the book success' do
      expect { delete_book }.to change { Book.count }.by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
