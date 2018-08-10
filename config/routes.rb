Rails.application.routes.draw do
  devise_for :users, controllers:
    {omniauth_callbacks: "users/omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi|ja/ do
    root "static_pages#home"
  end

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "auth/:provider/callback", to: "omniauth_callbacks#create"
  get "auth/failure", to: "omniauth_callbacks#failure"

  get "/register", to: "users#register_card"
  patch "/register", to: "users#require_card"

  resources :users
  resources :books do
    resources :comments
    resources :copies, only: %i(index new create update destroy)
  end
  resources :card_activations, only: %i(edit)
  resources :password_resets, only: %i(new create edit update)
  resources :registered_copies, only: %i(index new create update destroy)
  resources :book_confirmations, only: %i(index update destroy)
  resources :comment_confirmations, only: %i(index update destroy)
end
