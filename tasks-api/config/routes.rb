Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace dos controladores sem afetar o URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :tasks do
      resources :items
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end
