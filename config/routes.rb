Flow::Application.routes.draw do
  root :to => 'articles#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/sign_out' => 'sessions#destroy', :as => 'sign_out'
  match '/sign_in'  => 'sessions#new',     :as => 'sign_in'

  resources :articles, :except => :show
  resources :users
end
