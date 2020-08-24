Rails.application.routes.draw do
  resources :tasks do
    resources :items
  end
end
