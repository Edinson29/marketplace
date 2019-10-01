Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
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
