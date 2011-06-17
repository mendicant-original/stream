Flow::Application.routes.draw do

  root :to => 'articles#index'

  match '/auth/:provider/callback',      :to => 'sessions#create'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  match '/login' => 'sessions#new',      :as => 'login'
  
  resources :articles

  resources :users
  
end
