# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { 'Book close' }
    read { false }

    user
  end
end
