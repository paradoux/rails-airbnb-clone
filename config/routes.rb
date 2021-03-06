Rails.application.routes.draw do


  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

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

  get '/articles/search', to: 'articles#search'

  get 'orders/:id/:status', to: 'orders#change_statut', as: 'change_statut'

end
