# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'choose_avatar', to: 'users/registrations#choose_avatar', as: :choose_avatar
    put 'choose_avatar', to: 'users/registrations#choose_avatar'
  end

  root to: 'home#index'

  resources :books
end
