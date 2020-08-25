Rails.application.routes.draw do
  resources :tasks do
    resources :items
  end
  post 'auth/login', to: 'authentication#authenticate'
end
