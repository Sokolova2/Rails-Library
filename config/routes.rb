# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'home#index'

  resources :books do
    resources :likes
    resources :comments
    put 'update_status', to: 'update_book_status#update'
    resource :ratings
  end

  resources :history

  resources :tops, only: %i[index]

  resource :favorites

  get 'update_avatar_users', to: 'update_avatar_users#choose_avatar', as: :choose_avatar
  put 'update_avatar_users', to: 'update_avatar_users#choose_avatar'
end
