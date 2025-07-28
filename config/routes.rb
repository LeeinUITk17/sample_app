Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  scope "(:locale)", locale: /en|vi/ do
    root "microposts#index"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    
    resources :microposts
    resources :users
    resources :account_activations, only: [:edit]
    resources :password_resets,     only: [:new, :create, :edit, :update]
  end
end

