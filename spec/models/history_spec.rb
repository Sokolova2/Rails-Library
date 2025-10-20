# frozen_string_literal: true

require 'rails_helper'

RSpec.describe History, type: :model do
  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'field' do
    it { is_expected.to have_field(:status).of_type(String) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book).of_type(Book) }
    it { is_expected.to belong_to(:user).of_type(User) }
  end
end
