# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SetRandomAvatarService, type: :service do
  let(:user_with_gender) { build(:user, gender: 'female', avatar: nil) }
  let(:user_without_gender) { build(:user, gender: nil, avatar: nil) }

  describe '#set_random_avatar' do
    context 'when user have gender' do
      subject(:service) { described_class.new(user_with_gender) }

      it 'add avatar for user from directory his gender' do
        female_files = Rails.root.glob('app/assets/images/female/*').map { |f| File.basename(f) }

        service.set_random_avatar

        expect(user_with_gender.avatar).to be_present
        expect(female_files).to include(user_with_gender.avatar.file.filename)
      end
    end

    context 'when user do not have gender' do
      subject(:service) { described_class.new(user_without_gender) }

      it 'add avatar for user from directory animal' do
        animal_files = Rails.root.glob('app/assets/images/animal/*').map { |f| File.basename(f) }

        service.set_random_avatar

        expect(user_without_gender.avatar).to be_present
        expect(animal_files).to include(user_without_gender.avatar.file.filename)
      end
    end
  end
end
