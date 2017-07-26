Rails.application.routes.draw do

  devise_for :users
  resources :posts
  resources :users
  resources :friendships, only: [:create, :update, :destroy, :index, :new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

end
