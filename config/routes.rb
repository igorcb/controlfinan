Rails.application.routes.draw do
  #get 'static_pages/dashboard'
  resources :current_accounts 
  match '/moviments', controller: :static_pages, action: :moviment, via: [:get]
  match '/dashboard', :controller => 'static_pages', :action => 'dashboard', via: [:get, :post]
  match '/search_account', :controller => 'current_accounts', :action => 'search', via: [:get, :post]

  devise_for :users

  root to: 'current_accounts#index'
end
