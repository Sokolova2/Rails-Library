# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'fields' do
    it { is_expected.to have_field(:content).of_type(String) }
    it { is_expected.to have_field(:read).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).of_type(User) }
  end
end
