# config/routes.rb
Rails.application.routes.draw do
  # ログインしていない場合はログインページにリダイレクト
  root 'sessions#new'
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :todos
  
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  
  # Rails 7でのUJS対応のため、GETでもログアウトできるようにする（オプション）
  get '/logout', to: 'sessions#destroy'
end