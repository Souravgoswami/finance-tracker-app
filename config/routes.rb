Rails.application.routes.draw do
  get 'search_stock', to: 'stocks#search'
  get 'my_portfolio', to: 'users#my_portfolio'
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'
end
