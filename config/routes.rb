Rails.application.routes.draw do

  root to: 'pages#index'

  devise_for :users,
              path: '',
              path_names: {sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout'},
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations'}

  resources :users, only: [:show]
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
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
