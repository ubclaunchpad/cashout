Rails.application.routes.draw do

    get 'home/index'

    resources :purchases, only: [:index, :new, :create]

    # Automatically sets up Devise-specific routes
    devise_for :users, :controllers => {:registrations => "users/registrations"}

    # This is the root url
    root to: "home#index"
end
