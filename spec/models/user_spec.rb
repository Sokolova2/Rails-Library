# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe 'matchers' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'fields' do
    it { is_expected.to have_field(:login) }
    it { is_expected.to have_field(:email).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:encrypted_password).of_type(String).with_default_value_of('') }
    it { is_expected.to have_field(:uid) }
    it { is_expected.to have_field(:provider) }
    it { is_expected.to have_field(:reset_password_token).of_type(String) }
    it { is_expected.to have_field(:reset_password_sent_at).of_type(Time) }
    it { is_expected.to have_field(:remember_created_at).of_type(Time) }
    it { is_expected.to have_field(:gender).of_type(String) }
    it { is_expected.to have_field(:avatar).of_type(String) }
    it { is_expected.to have_field(:language).of_type(String) }
    it { is_expected.to have_field(:admin).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:books) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:histories) }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:favorites) }
    it { is_expected.to have_many(:impressions) }
    it { is_expected.to have_many(:messages) }
  end

  describe 'methods' do
    context 'set random avatar' do
      subject { user.set_random_avatar }

      it 'check that user have avatar' do
        subject
        expect(user.avatar).to be_present
      end
    end
  end
end
