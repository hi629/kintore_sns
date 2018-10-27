Rails.application.routes.draw do

  get 'notifications/link_through'

  resources :likes, only:[:create, :destroy]
  devise_for :users, :controllers => {:registrations=> "registrations"}
  resources :posts do
    resources :comments
  end

  resources :relationships, only:[:create, :destroy]
  # root 'posts#index'
  root 'pages#index'
  
  get '/posts/hashtag/:name', to:'posts#hashtags'
  get 'search' => 'pages#search'
  get '/about' => 'pages#about'

  resources :users do
    member do
      get :following, :followers
    end
  end

  get 'notifications', to: 'notifications#list'
  get 'notifications/:id/link_through', to:'notifications#link_through', as: :link_through
end
