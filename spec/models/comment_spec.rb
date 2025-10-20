# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'fields' do
    it { is_expected.to have_field(:content).of_type(String) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).of_type(User) }
    it { is_expected.to belong_to(:book).of_type(Book) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:content).with_minimum(1) }
  end
end