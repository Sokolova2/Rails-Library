# frozen_string_literal: true

FactoryBot.define do
  factory :impression do
    association :book, factory: :book
    association :user, factory: :user, optional: true
  end
end
