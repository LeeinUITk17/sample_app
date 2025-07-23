Rails.application.routes.draw do
  get 'sessions/new'
  root "microposts#index"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :microposts
  resources :users
end
