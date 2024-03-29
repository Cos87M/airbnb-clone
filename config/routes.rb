Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

    resources :users, only: :show

    get "/users_by_email" => "users_by_emails#show", as: :users_by_email

  resources :favorites, only: [:create, :destroy]

  get "/properties/search" => "properties/search#index"

  resources :properties, only: :show do
    resources :reservations, only: :new, controller: "property_reservations"
  end

  resources :reservation_payments, only: :create

  resources :profiles, only: [:show, :update]

  resources :accounts, only: [:show, :update]

  resources :passwords, only: [:show, :update]

  resources :payments_sidebar, only: [:index]

  put "/hostify/:user_id" => "hostify#update", as: :hostify

  namespace :host do
    get "/dashboard" => "dashboard#index", as: :dashboard

    # resources :properties, except: :index
    resources :properties, only: [:new, :create]

    resources :payments, only: :index
  end


end
