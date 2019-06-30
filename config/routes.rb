class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
=begin
  constraints(host: /^(?!www\.)/i) do
    match '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host = "www.#{uri.host}" }.to_s
    }
  end
=end

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

  get "/robots.:format", to: "pages#robots"
  get '/contact', to: 'pages#contact'
  get '/services', to: 'pages#services'

  get '/confirmation_instructions', to: 'device#mailer#confirmation_instructions'
  get '/sitemap.xml' => 'sitemaps#index', defaults: { format: 'xml' }
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"

  resources :subscribers
  resources :users, only: [:show] do
    put 'update_avatar', on: :collection
  end
  resources :hommages do
    get 'search', on: :collection
    get 'list', on: :collection
  end
  resources :messages do
    get 'search', on: :collection
  end
  resources :recipients_messages
  resources :photos
end
