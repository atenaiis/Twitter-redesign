Rails.application.routes.draw do
  root 'users#profile'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout' => 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'
  resources :users, only: ['show', 'destroy']
  get '/users/:id/follow', to: 'users#follow', as: 'follow'
  get '/users/:id/unfollow', to: 'users#unfollow', as: 'unfollow'

  resources :opinions, only: ['create']
end

