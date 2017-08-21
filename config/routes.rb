Rails.application.routes.draw do

  devise_for :users
  root to: 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Attachinary::Engine => "/attachinary"

  get'pages/concept'

  resources :articles, only: [:index, :create, :new, :destroy, :update]

  get '/achats', to: "orders#my_achats_index"
  get '/achats/order_id', to: "orders#show_achat"
  get 'achats/article_id', to: "orders#new_achat"
  get '/achats/order_id/edit', to: "orders#edit_achat"
  get 'achats/order_id//delete', to: "orders#destroy_achat"


  get '/test', to: "orders#test"

end
