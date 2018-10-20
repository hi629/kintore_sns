Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations=> "registrations"}
  resources :posts

  resources :relationships, only:[:create, :destroy]
  root "posts#index"

  resources :users do
    member do
      get :following, :followers
    end
  end
end
