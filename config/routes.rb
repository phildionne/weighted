Weighted::Application.routes.draw do

  namespace :settings do
    resource :profile, :only => [:show, :update]
  end

  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  devise_scope :user do
    # Not added by default while using devise with omniauth
    delete '/users/sign_out'   => 'devise/sessions#destroy'
    get    'settings/account'  => 'devise/registrations#edit'
  end

  resource :search, :only => [:show, :create]

  resources :users, :only => :show do
    member do
      get :followed_collections
    end
  end

  resources :collections do
    resources :sources, :only => [:index, :new, :create]
    resources :contents, :only => [:index, :show]
    member do
      get :followers
    end
  end

  resources :sources, :only => [:show, :edit, :update, :destroy] do
    resources :contents, :only => [:new, :create, :destroy]
  end

  resources :follows, only: [:create, :destroy]

  get 'pages/about'   => 'high_voltage/pages#show', id: 'about'
  get 'pages/contact' => 'high_voltage/pages#show', id: 'contact'

  root :to => 'frontpage#show'

  unless Rails.application.config.consider_all_requests_local
    match '*a', to: 'errors#not_found'
  end
end
