Rails.application.routes.draw do
  root "microposts#index"
  get "/contact", to: "static_pages#contact"
  resources :microposts, only: [:index]
end
