class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             controllers: {
                registrations: "users/registrations",
                confirmations: "users/confirmations",
                omniauth_callbacks: "users/omniauth_callbacks"
             },
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 edit: 'profile',
                 show: ''
                 # password: 'secret',
                 # confirmation: 'verification',
                 # unlock: 'unblock',
                 # registration: 'register',
                 # sign_up: 'connect'
             }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get '/contact', to: 'pages#contact'
  get '/services', to: 'pages#services'

  get '/confirmation_instructions', to: 'device#mailer#confirmation_instructions'
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"

  resources :subscribers
  resources :users, only: [:show]
  resources :hommages do
    get 'search', on: :collection
    get 'list', on: :collection
  end
  resources :photos
end
