# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'assocations' do
    it { is_expected.to belong_to(:user).of_type(User) }
    it { is_expected.to belong_to(:book).of_type(Book) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:book_id) }
  end
end
