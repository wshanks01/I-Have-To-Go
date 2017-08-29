Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :ratings
  resources :bathrooms do
    resources :ratings
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  mount_devise_token_auth_for 'Admins', at: 'admin-auth'
  as :admins do
    # Define routes for Admins within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
