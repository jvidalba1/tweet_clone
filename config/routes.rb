Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "feed", to: "pages#feed"

  resources :users, param: :username do
    member do
      get 'following'
      get 'followers'
      get 'finder'
      post 'follow_finder'
      post 'follow'
      post 'unfollow'
    end

    resources :tweets, only: [:new, :create]
  end
end
