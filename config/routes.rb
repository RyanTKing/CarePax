Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'order' => 'static_pages#order'
  get 'help' => 'static_pages#help'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
end
