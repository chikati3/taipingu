Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games, only: [:index, :new, :create, :destroy]
  resources :users, only: :show
  resources :games, only: [:index] do
    collection do
      get 'search'
    end
  end
end
