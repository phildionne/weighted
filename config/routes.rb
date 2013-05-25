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

  resources :users, :only => :show do
    member do
      get :followed_collections
    end
  end

  resources :collections do
    resources :contents
    member do
      get :followers
    end
  end

  resources :follows, only: [:create, :destroy]

  get 'pages/about'   => 'high_voltage/pages#show', id: 'about'
  get 'pages/contact' => 'high_voltage/pages#show', id: 'contact'

  root :to => 'high_voltage/pages#show', id: 'frontpage'

  unless Rails.application.config.consider_all_requests_local
    match '*a', to: 'errors#not_found'
  end
end
