# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Alice in Wonderland' }
    descriptions { "Alice's Adventures in Wonderland by Lewis Carroll is a classic children's novel about a curious girl named Alice who follows the White Rabbit down a hole into a bizarre, dreamlike world. There, she has nonsensical adventures with peculiar characters like the Mad Hatter, the Cheshire Cat, and the tyrannical Queen of Hearts, encountering challenges that question logic and reality. The story explores themes of identity, authority, and the absurdity of the adult world through its inventive plot, wordplay, and enduring influence on popular culture." }
    author { 'Lewis Carroll' }
    status { 'Open' }
    genre { 'Adventure' }
    views { 0 }
    image { File.open(Rails.root.join('app/assets/images/wallpapper.jpg').open) }
  end
end