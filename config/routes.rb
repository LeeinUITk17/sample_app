Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "microposts#index"
    get "/contact", to: "static_pages#contact"
    resources :microposts, only: [:index]
  end
end

