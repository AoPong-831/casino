Rails.application.routes.draw do
  get 'receptions/index'
  resources :users
  root 'top#index'
  get "top/login_page"
  post "top/login"
  get  'top/logout'
  
  get "users/index/:id", to: "users#index"
  get "users/withdraw/:id", to: "users#withdraw"
  get "users/deposit/:id", to: "users#deposit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
