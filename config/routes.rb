Rails.application.routes.draw do
  resources :users
  root 'top#index'
  get "top/login_page"
  post "top/login"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
