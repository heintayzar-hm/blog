Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new] do
      resources :comments, only: [:new]
    end
  end
  post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'
  delete '/users/:user_id/posts/:post_id', to: 'posts#destroy', as: 'delete_user_post'
  post '/users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'create_user_post_comment'
  delete '/users/:user_id/posts/:post_id/comments/:comment_id', to: 'comments#destroy', as: 'delete_user_post_comment'
  post '/users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'create_user_post_like'

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }

      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :new] do
          resources :comments, only: [:show]
        end
      end
      post '/users/:user_id/posts', to: 'posts#create', as: 'create_api_user_post'
      post '/users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'create_api_user_post_comment'
    end
  end
end
