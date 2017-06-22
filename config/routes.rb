Rails.application.routes.draw do
  resources :categories
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'session/new'
  get 'users/index'
  resources :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :articles
  resources :galleries
  resources :companies
  resources :products
  get 'signup', to: 'users#new'
  
  # get 'users', to: 'users#index'
  #get 'pages/home'
  root 'pages#home'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
