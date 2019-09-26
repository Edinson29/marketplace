Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :categories
  resources :users
  resources :products  do
    member do
      put :archived, :publish, :unpublish
    end
  end
  get '/my_products', to: 'products#my_products'
  root 'products#index'
end
