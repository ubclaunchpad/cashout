Rails.application.routes.draw do

    get 'home/index'

    resources :purchases, only: [:index, :new, :create]

    # Automatically sets up Devise-specific routes
    devise_for :users, :controllers => {:registrations => "users/registrations"}

    # summary_controller requests
    get '/portfolio',    to: 'summary#show_portfolio'
    get '/snapshot',     to: 'summary#show_snapshot'
    get '/difference',   to: 'summary#show_diff'

    # This is the root url
    root to: "home#index"
end
