Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'pages#index'

  resources :articles do
    resources :stocks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
  resources :tags, only: [:show, :index], param: :name do
    resource :tagfollow, only: [:create, :destroy], path: 'follow'
  end
end
