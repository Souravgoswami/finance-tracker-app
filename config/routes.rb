Rails.application.routes.draw do
  resources :friendships, only: %i[create destroy]
  get 'search_friend', to: 'users#search'
  get 'my_friends', to: 'users#my_friends'
  get 'check_username', to: 'checks#username'
  get 'check_email', to: 'checks#email'
  resources :user_stocks, only: %i[create destroy]
  get 'search_stock', to: 'stocks#search'
  get 'my_portfolio', to: 'users#my_portfolio'
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'
  get 'users/:id', to: 'users#show', as: 'user'
  post 'refresh_user_stock', to: 'user_stocks#refresh'
end
