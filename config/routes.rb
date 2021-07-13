Rails.application.routes.draw do
  root 'users#index'
  post 'users/create' 
  post 'users/login'
  get 'users/:id/edit' => 'users#edit'
  patch 'users/:id/edit' => 'users#update'
  delete 'users/destroy'

  get 'events' => 'events#index'
  post 'events/create' => 'events#create'
  get 'events/:id' => 'events#show'
  patch 'events/:id' => 'events#join'
  delete 'events/:id' => 'events#unjoin'
  get 'events/:id/edit' => 'events#edit'
  patch 'events/:id/edit' => 'events#update'
  post 'events/:id/comment' => 'events#comment'
  delete 'events/:id/delete' => 'events#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
