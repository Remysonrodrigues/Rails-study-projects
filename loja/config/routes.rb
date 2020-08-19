Rails.application.routes.draw do
  #delete "produtos/:id", to: "produtos#destroy", as: :produto
  #post "produtos", to: "produtos#create"
  #get "produtos/new", to: "produtos#new"
  get "produtos/busca", to: "produtos#busca", as: :busca_produto
  resources :produtos, only: [:new, :create, :destroy]
  root to: "produtos#index"
end
