Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'pages#index'

  resources :articles do
    resources :stocks
  end

  resources :users, only: :show
end
