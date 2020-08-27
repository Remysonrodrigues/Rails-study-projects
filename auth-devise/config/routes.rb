Rails.application.routes.draw do
  get 'control_users/index'
  resources :addresses
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  resources :products
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
