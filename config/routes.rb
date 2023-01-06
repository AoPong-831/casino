Rails.application.routes.draw do
  get 'receptions/index'
  resources :users
  resources :receptions
  root 'top#index'
  get "top/login_page"
  post "top/login"
  get  'top/logout'
  
  get "users/index/:id", to: "users#index"
  get "users/withdraw/:id", to: "users#withdraw"
  get "users/deposit/:id", to: "users#deposit"
  get "users/debt/:id", to: "users#debt"
  get "users/hensai/:id", to: "users#hensai"
  get "users/yuushi/:id", to: "users#yuushi"
  #get "receptions/:id", to: "receptions#show"
  #delete "receptions/:id" ,to: "receptions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
