Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :users
  resources :products
  root 'products#index'
  get '/my_products', to: 'products#my_products'
  put '/products/:id/publish', to: 'products#publish'
  put '/products/:id/unpublish', to: 'products#unpublish'
  put '/products/:id/archived', to: 'products#archived'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
