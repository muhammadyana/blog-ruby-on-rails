Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks' }
  get 'article/service' => 'articles#service'
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
    # get 'login', to: 'devise/sessions#new'
    # get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    # put 'users' => 'devise/registrations#update', :as => 'user_registration'
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
  root 'articles#index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
