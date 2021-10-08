Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'tasks#index'

  resources :users, only: [:create,:update, :show]
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/mypage', to: 'users#mypage', as: 'mypage'
  get '/mypage/edit', to: 'users#edit', as: 'edit_mypage'

  namespace :admin do
    resources :users
  end
end
