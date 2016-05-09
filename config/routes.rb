Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'welcome#index'
  get 'drafts', to: 'welcome#drafts'
  get 'mine', to: 'welcome#mine'
  get 'stocks', to: 'welcome#stocks'

  resources :articles do
    resource :stock, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: :show do
    member do
      get :stocks
      get :articles
      get :followers
    end
    resource :relationship, only: [:create, :destroy], path: 'follow'
    resource :profile, except: [:destroy]
  end

  resources :tags, only: [:show, :index], param: :name do
    resource :tagfollow, only: [:create, :destroy], path: 'follow'
  end
end
