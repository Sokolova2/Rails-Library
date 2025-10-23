# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'Great' }
    user
    book
  end
end
