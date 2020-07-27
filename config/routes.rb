Rails.application.routes.draw do
  root 'welcome#welcome'
  resources :users
  get '/login', to: 'session#login'
  delete '/logout', to: 'session#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
