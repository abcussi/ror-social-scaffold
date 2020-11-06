Rails.application.routes.draw do
  resources :friendships
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: %i[new create destroy update]
  end
  
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
