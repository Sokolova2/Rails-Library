# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { create(:book) }

  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'fields' do
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:descriptions).of_type(String) }
    it { is_expected.to have_field(:author).of_type(String) }
    it { is_expected.to have_field(:status).of_type(String).with_default_value_of('Open') }
    it { is_expected.to have_field(:genre).of_type(String) }
    it { is_expected.to have_field(:views).of_type(Integer).with_default_value_of(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).of_type(User) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:histories) }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:favorites) }
    it { is_expected.to have_many(:impressions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:descriptions) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_length_of(:title).with_maximum(40) }
    it { is_expected.to validate_length_of(:author).with_maximum(40) }
  end

  describe 'methods' do
    context 'search' do
      let(:search) { 'Alice in Wonderland' }

      it 'return all books with the search term' do
        subject
        expect(Book.search('Alice').map(&:title)).to include(search)
      end
    end
  end
end
