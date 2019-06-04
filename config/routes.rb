class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  devise_for :users, :path=>'',
                      :path_names=>{:sign_in=>'login', :sign_out=>'logout', :edit=>'profile'},
                      :controllers=>{ :omniauth_callbacks => "omniauth_callbacks", :registrations=>'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  resources :subscribers
  resources :users, only: [:show]
  resources :hommages do
    get 'search', on: :collection
    get 'list', on: :collection
  end
  resources :photos
  resources :memories
end
