# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService, type: :service do
  let(:books) { Book.all }

  before do
    10.times.map { |_number| create(:book) }
    books[0].update(title: books[1].title)
  end

  describe '#search' do
    subject(:service) { described_class.new(books) }
    let(:search) { books.first.title }

    context 'when search present' do
      it 'gets all books with same title' do
        expect(service.search(books.first.title).pluck(:title)).to include(search)
      end
    end

    context 'when search blank' do
      it 'gets all books' do
        expect(service.search('')).to match_array(books)
      end
    end
  end
end
