Rails.application.routes.draw do

  root to: "books#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :books do
    member do
      post 'borrow', to: 'books#borrow'
      post 'return', to: 'books#return'
      post 'deactive', to: 'books#deactive'
    end
  end

  resources :loans, only: [:index]

  get '*path', to: redirect('/')

end
