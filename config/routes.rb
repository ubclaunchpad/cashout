Rails.application.routes.draw do

  get 'home/index'

  resources :purchases

  # Automatically sets up Devise-specific routes
  devise_for :users

  # This is the root url
  root to: "home#index"
end
