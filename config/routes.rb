# frozen_string_literal: true
Rails.application.routes.draw do
  default_url_options :host => "example.com"

  resources :gladiators do
    collection do
      get :the_ludus
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#index'
end
