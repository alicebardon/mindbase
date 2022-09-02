Rails.application.routes.draw do
  devise_for :users
  root "categories#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :categories do
    resources :notes, except: %i[new create show index]
  end
  resources :notes, only: %i[new create]
end
