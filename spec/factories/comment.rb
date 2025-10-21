# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'Great' }

    association :user, factory: :user
    association :book, factory: :book
  end
end
