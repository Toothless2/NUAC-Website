Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations' }
  root to: 'posts#index'

  resources :posts
  
  resources :page_contents, only: [:edit, :update, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
