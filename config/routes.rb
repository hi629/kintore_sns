Rails.application.routes.draw do

  resources :likes, only:[:create, :destroy]
  devise_for :users, :controllers => {:registrations=> "registrations"}
  resources :posts do
    resources :comments
  end

  resources :relationships, only:[:create, :destroy]
  # root "posts#index"
  root "pages#index"
  
  get '/posts/hashtag/:name', to:'posts#hashtags'
  get 'search' => 'pages#search'
  get '/about' => 'pages#about'

  resources :users do
    member do
      get :following, :followers
    end
  end
end
