Rails.application.routes.draw do
  resources :comments
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: %i[:destroy, :edit]
  resources :followings, only: [:create, :destroy, :new]
  root to: 'comments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/startfollow/:id', to: 'followings#create'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get '/follow/:list', to: 'users#index'
end
