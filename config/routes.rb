Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'business_qr_codes/show'

  namespace :admin do
    resources :administrators
    resources :customers
    resources :owners
    resources :businesses
    resources :business_follows
    resources :menus
    resources :categories
    resources :items
    resources :tags
    resources :item_tags
    resources :happy_prices
    resources :happy_codes

    root to: 'administrators#index'
  end

  # No sign up for admin
  get '/administrators/sign_up', to: 'static_pages#you_tried'
  devise_for :administrators
  devise_for :customers, controllers: { omniauth_callbacks: 'customers/omniauth_callbacks' }
  devise_for :owners
  devise_scope :customer do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # For Owners, some REST actions exept show are handle by devise :
  resources :owners, only: [:show]
  resources :customers, only: [:show]
  resources :business_follows, only: %i[create destroy]
  resources :happy_prices, only: [:index]

  resources :businesses do
    resources :menus, only: %i[show new create edit update destroy] do
      resources :menu_items, only: %i[create destroy]
    end
    resources :items do
      resources :happy_prices, only: %i[new create edit update destroy] do
        resources :happy_codes, only: %i[create]
      end
      resources :item_photos, only: [:create]
      resources :item_tags, only: %i[create destroy]
    end
    resources :business_photos, only: [:create]
    resources :business_qr_codes, only: [:index]
  end

  # Root is index of all businesses
  root 'businesses#index'

  get '/kit_ui', to: 'static_pages#kit_ui'
end
