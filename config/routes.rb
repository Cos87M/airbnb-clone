Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

  get '/tailwindcss/base', to: redirect('/path/to/application.scss')
  get '/tailwindcss/components', to: redirect('/path/to/components.css')
  get '/tailwindcss/utilities', to: redirect('/path/to/utilities.css')
end
