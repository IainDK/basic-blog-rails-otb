Rails.application.routes.draw do
  root 'posts#index'
  
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :posts do
    resources :comments
  end
end
