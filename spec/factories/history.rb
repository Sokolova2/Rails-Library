# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    status { 'took' }
    association :book
    association :user
  end
end
