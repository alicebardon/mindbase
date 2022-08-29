Rails.application.routes.draw do
  get 'notes/new'
  get 'notes/create'
  get 'notes/edit'
  get 'notes/update'
  get 'notes/destroy'
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :categories do
    resources :notes, except: %i[show index]
  end
end
