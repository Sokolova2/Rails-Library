# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    status { 'took' }
    association :book, factory: :book
    association :user, factory: :user
  end
end
