Rails.application.routes.draw do

  devise_for :users
  root to: 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Attachinary::Engine => "/attachinary"

  get'pages/concept'

  resources :articles, only: [:index, :create, :new, :destroy, :update]

  get '/achats', to: "orders#my_achats_index"
  get '/achats/order_id', to: "orders#myorder", as: 'myorders'
  get 'achats/article_id', to: "orders#new_achat"
  post 'achats/', to: "orders#create", as: "new_order"
  get '/achats/order_id/edit', to: "orders#edit_achat"
  delete 'achats/order_id//delete', to: "orders#destroy", as: 'destroy_order'


  get '/test', to: "orders#myachatsindex"

end
