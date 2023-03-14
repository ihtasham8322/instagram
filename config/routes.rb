# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/user/index', to: 'user#index', as: 'user_index'
  resources :user, only: %i[index update show edit]
  resources :post, except: [:show], shallow: true do
    resources :comments
    resources :likes, only: %i[create destroy]
  end
  resources :story, only: %i[new create show destroy]
  resources :follower, only: %i[update edit]

  get :search, to: 'user#search', as: 'search'
  get 'account_privacy/:id', to: 'user#account_privacy', as: 'account_privacy'
  post :send_request, to: 'follower#send_request', as: 'send_request'

  root to: 'user#account', as: 'account'
end
