Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users,
              path: '',
              path_names: {sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout'},
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations'}

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number', to: 'users#verify_phone_number'
      patch '/update_phone_number', to: 'users#update_phone_number'

    end
  end
  resources :rooms, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
      get 'preload'
      get 'preview'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
  end

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]
  get '/your_trips', to: 'reservations#your_trips'
  get '/your_reservations', to: 'reservations#your_reservations'

  get 'search', to: 'pages#search'
  get 'dashboard', to: 'dashboards#index'

  resources :reservations, only: [:approve, :decline] do
    member do
      post '/approve', to: "reservations#approve"
      post '/decline', to: "reservations#decline"
    end
  end

  get '/host_calendar', to: "calendars#host"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
