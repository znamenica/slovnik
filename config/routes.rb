# frozen_string_literal: true

Rails.application.routes.draw do
   devise_for :users, controllers: { sessions: "app_sessions" }
   # mount Tiun::Engine, at: '/api'
   # Tiun::Engine.routes
   root to: "application#home"

   resources :users, only: %i(index show)
   get "/me" => "users#me"
   put "/me" => "users#upme"
   resources :novelties, path: "/news", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :libra, path: "/library", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :meanings, path: "/m", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :languages, path: "/l", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :alphabeths, path: "/a", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :dictionaries, path: "/d", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :grammars, path: "/g", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :attitudes, path: "/at", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :tags, path: "/t", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :pieces, path: "/p", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :articles, path: "/c", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :dicta, path: "/s", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :socials, path: "/so", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)
   resources :accounts, path: "/ac", defaults: { format: :json }, constraints: { format: "json" }, except: %i(new edit)

   mount Sidekiq::Web => "/dashboard/sidekiq" if !Rails.env.test?

   get "/404" => "errors#not_found"
   get "/500" => "errors#exception"
end
