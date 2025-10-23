# frozen_string_literal: true

FactoryBot.define do
  factory :impression do
    book
    user
  end
end
