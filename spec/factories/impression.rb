# frozen_string_literal: true

FactoryBot.define do
  factory :impression do
    association :book
    association :user, optional: true
  end
end
