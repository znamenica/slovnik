Rails.application.routes.draw do
   devise_for :users, controllers: { sessions: 'app_sessions' }
   # mount Tiun::Engine, at: '/api'
   #Tiun::Engine.routes
   root to: "application#home"

   resources :novelties, path: '/news'
   resources :libra, path: '/library'
   resources :users, only: %i(index show)
end
