Rails.application.routes.draw do

  root to: 'posts#index'

  get 'aboutus', to: 'about_us#aboutus'
  get 'contactus', to: 'contact_us#contactus'
  get 'alumni', to: 'alumni#index'
  
  resources :committees, except: [ :index, :show ]
  devise_for :users, controllers: {registrations: 'registrations' }
  resources :posts
  resources :page_contents, only: [:edit, :update, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
