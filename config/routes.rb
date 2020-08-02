Rails.application.routes.draw do

  
  root 'welcome#welcome'
  
  get '/auth/google_oauth2/callback', to:'session#omniauth'

  get '/login', to: 'session#new'
  post 'login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get '/user/:id', to: 'users#show', as: 'user'

  resources :businesses
  resources :categories
  resources :neighborhoods do 
    resources :businesses
  end
  resources :users, only: [:new, :create, :show]
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
