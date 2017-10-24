Rails.application.routes.draw do

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  resources :participants
  resources :events do 
    resources :event_comments
  end
  devise_for :users
  resources :friends
  resources :posts do
    resources :likes
    resources :comments
  end  
  resources :users
  resources :friendships
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pages do 
    collection do
      get :home
    end
  end 
  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end 
  root 'pages#home'
end
