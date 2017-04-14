Rails.application.routes.draw do
  get 'notifications/index'
  resources :order_details
  resources :orders
  post 'groups/members', to: 'groups#members'
  post 'groups/add_member', to: 'groups#add_member'
  get 'friends', to: 'friends#index'
  post 'friends', to: 'friends#create'
  put 'friends/:id/accept', to: 'friends#accept'
  delete 'friends/:id/decline', to: 'friends#decline'
  get 'friends/:id/show', to: 'friends#show'
  delete 'friends/:id/remove', to: 'friends#remove'
  devise_for :users
  # resources :users
  root 'users#index'
  # resources :groups
  resources :groups do
  member do
    get 'members'
  end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
