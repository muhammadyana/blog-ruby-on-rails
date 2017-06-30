Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks', omniauth_callbacks: 'callbacks' }

  resources :categories
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
  end
  as :user do
    get 'login', to: 'devise/sessions#new'
  end
 
  get 'session/new'
  get 'users/index'
  resources :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :articles
  resources :galleries
  resources :companies
  resources :products
  #get 'signup', to: 'users#new'
  
  # get 'users', to: 'users#index'
  #get 'pages/home'
  root 'pages#home'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
