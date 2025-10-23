# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    score { 4 }

    user
    book
  end
end
