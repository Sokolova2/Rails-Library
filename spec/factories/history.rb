# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    status { 'took' }
    book
    user
  end
end
