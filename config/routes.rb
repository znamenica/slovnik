Rails.application.routes.draw do
   devise_for :users, controllers: { sessions: 'app_sessions' }
   # mount Tiun::Engine, at: '/api'
   #Tiun::Engine.routes
   root to: "application#home"

   resources :users, only: %i(index show)
   get '/me' => 'users#me'
   post '/me' => 'users#upme'
   resources :novelties, path: '/news'
   resources :libra, path: '/library'
   resources :meanings, path: '/m', defaults: { format: :json }, constraints: { format: 'json' }, except: %i(new edit)

   mount Sidekiq::Web => "/dashboard/sidekiq"
end
