# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title[0..39] }
    descriptions { 'The novel about a curious girl named Alice who follows the White Rabbit down' }
    author { 'Lewis Carroll' }
    status { 'Open' }
    genre { 'Adventure' }
    views { 0 }
    image { File.open(Rails.root.join('app/assets/images/wallpapper.jpg').open) }
  end
end
