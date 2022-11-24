# frozen_string_literal: true

if defined?(Sidekiq)
   Sidekiq.strict_args!

   Sidekiq.default_job_options = { "backtrace" => true }

   if redis_uri = ENV.fetch("REDIS_URL", nil)
      require "sidekiq/worker_killer"

      Sidekiq.configure_server do |config|
         config.redis = { url: "#{redis_uri}/4", namespace: "caching" }

         config.server_middleware do |chain|
            chain.add Sidekiq::WorkerKiller, max_rss: 480
         end

         config.average_scheduled_poll_interval = 2
         # TODO sentry
         # config.error_handlers << proc {|ex,ctx_hash| MyErrorService.notify(ex, ctx_hash) }
      end

      Sidekiq.configure_client do |config|
         config.redis = {
            url: "#{redis_uri}/4", namespace: "caching",
         }
      end
   end
end
