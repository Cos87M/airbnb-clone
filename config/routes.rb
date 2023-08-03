Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

    resources :users, only: :show

      get "/users_by_email" => "users_by_emails#show", as: :users_by_email

  resources :favorites, only: [:create, :destroy]

  resources :properties, only: :show do
    resources :reservations, only: :new, controller: "property_reservations"
  end

  resources :reservation_payments, only: :create

  resources :profiles, only: [:show, :update]

  resources :accounts, only: [:show, :update]

end
