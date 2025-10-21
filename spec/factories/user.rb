# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { 'test_user' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
