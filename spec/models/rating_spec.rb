# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'field' do
    it { is_expected.to have_field(:score).of_type(Integer) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).of_type(User) }
    it { is_expected.to belong_to(:book).of_type(Book) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:score) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:book_id) }
  end
end
