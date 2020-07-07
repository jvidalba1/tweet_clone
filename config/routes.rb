Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, param: :username, only: [:show] do
    member do
      get 'following'
      get 'followers'
      get 'finder'
      post 'follow_finder'
      post 'follow'
      post 'unfollow'
    end

    resources :tweets, only: [:new, :create, :index]
  end
end
