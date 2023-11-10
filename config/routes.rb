Rails.application.routes.draw do

  devise_for :users 

  get "up" => "rails/health#show", as: :rails_health_check

    root "users#index"
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show, :destroy]
    end

    resources :posts, only: [:new, :create, :destroy]
    resources :comments, only: [:destroy]

  post '/posts/:post_id/comments', to: 'comments#create', as: 'post_comments'
  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
end
