Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/categories/upload_file', to: 'categories#upload_file', as: 'upload'
  resources :categories do
    resources :notes, except: %i[new create show index]
  end
  resources :notes, only: %i[new create]
end
