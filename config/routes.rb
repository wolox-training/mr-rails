# Rails.application.routes.draw do
#   devise_for :users, ActiveAdmin::Devise.config
#   ActiveAdmin.routes(self)
#   resources :books, only: %I[index show]
#   resources :rents, only: %I[index create]
#   resources :book_suggestions, only: %I[create]
#   mount_devise_token_auth_for 'User', at: 'auth'
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   require 'sidekiq/web'
#   mount Sidekiq::Web => '/sidekiq'
# end

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth'
      end
    end
  end
  
  resources :books, only: %I[index show]
  resources :rents, only: %I[index create]
  resources :book_suggestions, only: %I[create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
