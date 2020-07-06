Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, param: :username do
    member do
      get 'following'
      get 'followers'
    end
  end
end
