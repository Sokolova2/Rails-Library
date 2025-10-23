# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:user_first) { create(:user, admin: true) }
  let(:user_second) { create(:user, admin: false) }
  let!(:book) { create(:book) }
  let(:valid_params) do
    { book: {
      title: 'New Book',
      descriptions: 'Some description',
      author: 'Author',
      image: fixture_file_upload(Rails.root.join('app/assets/images/wallpapper.jpg'), 'image/jpg'),
      genre: 'Adventure',
      status: 'Open'
    } }
  end

  describe 'GET /index' do
    subject(:get_index) { get books_path }

    before { get_index }

    it 'get all books' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    subject(:get_show) { get book_path(book) }

    before { get_show }

    it 'get show a page of a specific book' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    subject(:get_new) { get new_book_path }

    context 'when authorize as admin' do
      before do
        login_as(user_first, scope: :user)
        get_new
      end

      it 'gets a new book page' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when authorize does not as admin' do
      before do
        login_as(user_second, scope: :user)
        get_new
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST /create' do
    context 'when authorize as admin with valid parameters' do
      subject(:create_book) { post books_path, params: valid_params }

      before { login_as(user_first, scope: :user) }

      it 'create a new book success' do
        expect { create_book }.to change(Book, :count).by(1)
      end
    end

    context 'when authorize as admin with invalid parameters' do
      subject(:create_book) { post books_path, params: { book: { title: '' } } }

      before { login_as(user_first, scope: :user) }

      it 'not create a new book success' do
        expect { create_book }.not_to change(Book, :count)
      end
    end

    context 'when authorize does not as admin' do
      subject(:create_book) { post books_path, params: valid_params }

      before do
        login_as(user_second, scope: :user)
        create_book
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PUT /update' do
    context 'when authorize as admin with valid parameters' do
      subject(:update_book) { put book_path(book), params: { book: { title: 'Nice book' } } }

      before do
        login_as(user_first, scope: :user)
        update_book
      end

      it 'update the book success' do
        expect(book.reload.title).to eq('Nice book')
      end
    end

    context 'when authorize as admin with invalid parameters' do
      subject(:update_book) do
        put book_path(book), params: { book: { title: 'The Whisper of Forgotten Stars Beneath the Endless Sky' } }
      end

      before { login_as(user_first, scope: :user) }

      it 'not update the book success' do
        expect { :update_book }.not_to change(book, :title)
      end
    end

    context 'when authorize does not as admin' do
      subject(:update_book) { put book_path(book), params: { book: { title: 'Nice book' } } }

      before do
        login_as(user_second, scope: :user)
        update_book
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_book) { delete book_path(book), params: { book: { id: book.id } } }

    context 'when authorize as admin' do
      before { login_as(user_first, scope: :user) }

      it 'destroy the book success' do
        expect { delete_book }.to change(Book, :count).by(-1).and change { response }.to redirect_to(root_path)
      end
    end

    context 'when authorize does not as admin' do
      before { login_as(user_second, scope: :user) }

      it 'destroy the book success' do
        expect { delete_book }.not_to(change(Book, :count))
      end
    end
  end
end
