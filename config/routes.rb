Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'pages#index'

  resources :articles do
    collection do
      get :drafts # TODO: /:user/drafs もしくは /draftsとするべきかも
    end
    resources :stocks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: :show do
    member do
      get :stocks # TODO: /stockのほうが良いかも
    end
    resource :relationship, only: [:create, :destroy], path: 'follow'
  end

  resources :tags, only: [:show, :index], param: :name do
    resource :tagfollow, only: [:create, :destroy], path: 'follow'
  end
end
