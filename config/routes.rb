Rails.application.routes.draw do
  root 'static#home'
  get 'static/dashboard'
  resources :quotations
  resources :tubes
  resources :ratios
  resources :losses
  resources :individuals
  resources :companies
  resources :matters do
    collection do
      post :import
    end
  end
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
