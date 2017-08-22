Rails.application.routes.draw do

  devise_for :users
  root to: 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Attachinary::Engine => "/attachinary"

  get'pages/concept'

  resources :articles, only: [:index, :create, :new, :destroy, :update]

  get 'orders/myorders', to: 'orders#myorders', as: 'myorders'
  post 'orders/:id', to: 'orders#create', as: 'new_order'
  delete 'orders/:id', to: 'orders#destroy', as: 'destroy_order'

  get '/test', to: "orders#test"

  get 'orders/mysales', to: 'orders#mysales', as: 'mysales'

  get 'orders/:id/confirme', to: 'orders#acheteur_confirme', as: 'confirme'
  get 'orders/:id/prepare', to: 'orders#vendeur_prepare', as: 'prepare'
  get 'orders/:id/livre', to: 'orders#acheteur_pickup', as: 'livre'
  get 'orders/:id/annule', to: 'orders#annulation', as: 'annule'

end
