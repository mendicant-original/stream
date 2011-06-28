Flow::Application.routes.draw do
  root :to => 'articles#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/sign_out' => 'sessions#destroy', :as => 'sign_out'

  match '/about' => 'about#index'

  resources :articles, :except => :show
  resources :users, :except => [:new, :create]
end
