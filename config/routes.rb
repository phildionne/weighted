Weighted::Application.routes.draw do

  namespace :settings do
    resource :profile, :only => [:show, :update]
  end

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :omniauth_callbacks => 'omniauth_callbacks'
  }
  devise_scope :user do
    # Not added by default while using devise with omniauth
    delete '/users/sign_out' => 'devise/sessions#destroy'
    get 'settings/account' => 'devise/registrations#edit'
  end
  resources :users, :only => :show

  resources :collections do
    resources :contents
  end

  get 'pages/about' => 'high_voltage/pages#show', id: 'about'
  get 'pages/contact' => 'high_voltage/pages#show', id: 'contact'

  root :to => 'high_voltage/pages#show', id: 'frontpage'
end
