Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'tasks#index'

  resources :users, only: [:create]
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/mypage', to: 'users#show', as: 'mypage'

  namespace :admin do
    resources :users
  end
end
