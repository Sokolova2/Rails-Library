require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'field' do
    it { is_expected.to have_field(:login) }
    it { is_expected.to have_field(:email).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:encrypted_password).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:uid) }
    it { is_expected.to have_field(:provider) }
    it { is_expected.to have_field(:reset_password_token).of_type(String) }
  end

  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  # describe 'associations' do
  #   it { is_expected.to have_many(:books) }
  #   it { is_expected.to have_many(:likes) }
  #   it { is_expected.to have_many(:comments) }
  #   it { is_expected.to have_many(:histories) }
  #   it { is_expected.to have_many(:ratings) }
  #   it { is_expected.to have_many(:favorites) }
  #   it { is_expected.to have_many(:impressions) }
  #   it { is_expected.to have_many(:messages) }
  # end

  # describe 'methods' do
  #
  # end
end
