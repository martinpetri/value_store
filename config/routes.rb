Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :topics, only: [:index, :create, :destroy]
      resources :values, only: [:index, :create]
    end
  end  
  root 'pages#index'
  get 'pages/index'
  
  resources :values
  resources :topics
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
