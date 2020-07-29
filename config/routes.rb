Rails.application.routes.draw do
  get '/401', to: 'errors#unauthorised'
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'

  root to: 'posts#index'

  get 'aboutus', to: 'about_us#aboutus'

  get 'events', to: 'events#index'

  get 'contactus', to: 'contact_us#contactus'
  post 'contactus', to: 'contact_us#create'

  get 'alumni', to: 'alumni#index'
  
  resources :committees, except: [ :index, :show ]
  devise_for :users, controllers: {registrations: 'registrations', confirmations: 'confirmations' }
  resources :posts
  resources :page_contents, only: [:edit, :update, :new, :create]
  resources :records, except: [:show, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
