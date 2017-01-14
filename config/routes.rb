Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home/index'

  # Automatically sets up Devise-specific routes
  devise_for :users

  # This is the root url
  root to: "home#index"
end
