Rails.application.routes.draw do
  resources :users, except: :new
  mount Ckeditor::Engine => '/ckeditor'
  resources :articles
  resources :galleries
  resources :companies
  resources :products
  get 'signup', to: 'users#new', as: 'new_user'
  
  # get 'users', to: 'users#index'
  #get 'pages/home'
  root 'pages#home'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
