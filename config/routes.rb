Rails.application.routes.draw do
  get 'github/new'
  get 'github/create'
  get 'test/init'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "categories#index"

  post '/categories/upload_file', to: 'categories#upload_file', as: 'upload'
  resources :categories do
    resources :notes, except: %i[new create show index]
  end
  resources :notes, only: %i[new create]
  resources :github, only: %i[new create]
end
