# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :html } do
    devise_for :users
    get 'user/index'
  end

  namespace :api do
    namespace :v1 do
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      root 'user#index'
      resources :posts do
        resources :comments
      end
    end
  end
end
