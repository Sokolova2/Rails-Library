# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService, type: :service do
  let(:books) { create_list(:book, 10) }

  before do
    books.first.update(title: books.second.title)
  end

  describe '#search' do
    subject(:service) { described_class.new(Book.all) }

    let(:search_term) { books.first.title }

    context 'when search present' do
      it 'gets all books with same title' do
        expect(service.search(books.first.title).pluck(:title)).to include(search_term)
      end
    end

    context 'when search is blank' do
      it 'gets all books' do
        expect(service.search('').to_a).to match_array(books)
      end
    end
  end
end
