# frozen_string_literal: true
Rails.application.routes.draw do
  default_url_options :host => "example.com"

  resources :gladiators do
    collection do
      get :the_ludus
    end
  end
  
  resources :fights, except: [:update, :edit] do
    member do
      get :execute
    end
  end

  root 'pages#index'
end
