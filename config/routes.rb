require 'api_constraints'
Whippering::Application.routes.draw do

  root 'pages#welcome'

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users#, only: [:create, :new]

  # Api definition
  namespace :api, defaults: { format: :json },
                  constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
                  constraints: ApiConstraints.new(version: 1, default: true) do
      
      # We are going to list our resources here
      resources :users, :only => [:index, :show, :create, :update, :destroy] do

        resources :pitches, :only => [:show, :index, :create, :update, :destroy]

        resources :submissions, :only => [:index, :show, :create, :update, :destroy]

      end

      resources :sessions, :only => [:create, :destroy]

      scope :pitches do
       get 'landing_index', to: 'pitches#landing_index'
     end

      # scope :sessions do
      #   get 'is_signed_in', to: 'sessions#is_signed_in?'
      # end

    end

  end

end

