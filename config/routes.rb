Rails.application.routes.draw do
  root to: 'posts#index'

  get 'aboutus', to: 'about_us#aboutus'
  get 'contactus', to: 'contact_us#contactus'
  post 'contactus', to: 'contact_us#create'

  get 'alumni', to: 'alumni#index'
  
  resources :committees, except: [ :index, :show ]
  devise_for :users, controllers: {registrations: 'registrations', confirmations: 'confirmations' }
  resources :posts
  resources :page_contents, only: [:edit, :update, :new, :create]
  resources :records, only: [:index, :create, :destroy]
  
  delete 'user_soft_delete/:id', to: 'admin_pannel#soft_delete', as: 'user_soft_delete'
  delete 'user_hard_delete/:id', to: 'admin_pannel#hard_delete', as: 'user_hard_delete'
  put 'io_signups', to: 'admin_pannel#io_signups', as: 'io_signups'
  post 'admin_save_record', to: 'admin_pannel#admin_save_record', as: 'admin_save_record'
  put 'user_update_role/:id', to: 'admin_pannel#user_update_role', as: 'user_update_role'

  post 'increment_spider/:id/:dir', to: 'records#increment_spider', as: 'increment_spider'
  post 'increment_wp/:id/:dir', to: 'records#increment_wp', as: 'increment_wp'

  resources :admin_pannel, only: [:index]

  resources :events do
    member do
      put "response", to: "events#event_response"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
