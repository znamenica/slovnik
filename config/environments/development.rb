# frozen_string_literal: true

Rails.application.configure do
   # Settings specified here will take precedence over those in config/application.rb.

   # In the development environment your application's code is reloaded on
   # every request. This slows down response time but is perfect for development
   # since you don't have to restart the web server when you make code changes.
   config.cache_classes = false

   # Do not eager load code on boot.
   config.eager_load = false

   # Show full error reports.
   config.consider_all_requests_local = true

   # Enable/disable caching. By default caching is disabled.
   # Run rails dev:cache to toggle caching.
   if Rails.root.join("tmp", "caching-dev.txt").exist?
      config.action_controller.perform_caching = true

      config.cache_store = :memory_store, { size: 16.megabytes }

      #      config.cache_store = :redis_cache_store, {
      #         url: File.join(ENV.fetch("REDIS_URL", nil), "0"),
      #         driver: :hiredis,
      #         expires_in: 1.day,
      ##         key: "_#{Rails.application.class.name.split("::").first.downcase}_cache",
      #      }

      config.public_file_server.headers = {
         "Cache-Control" => "public, max-age=#{2.days.to_i}"
      }

      config.session_store = :cookie_store, {
         key: "_#{Rails.application.class.name.split("::").first.downcase}_session",
         domain: "127.0.0.1"
      }

   #      config.session_store = :redis_session_store, {
   ##        key: "_#{Rails.application.class.name.split("::").first.downcase}_session",
   #         redis: {
   #            driver: :hiredis,
   #            expire_after: 120.minutes,  # cookie expiration
   #            ttl: 120.minutes,           # Redis expiration, defaults to 'expire_after'
   #            key_prefix: "allslavic:session:",
   #            url: File.join(ENV.fetch("REDIS_URL", nil), "1")
   #         }
   #      }
   else
      config.action_controller.perform_caching = false

      config.cache_store = :null_store
   end

   # Store uploaded files on the local file system (see config/storage.yml for options)
   config.active_storage.service = :local

   # Don't care if the mailer can't send.
   config.action_mailer.raise_delivery_errors = false

   config.action_mailer.perform_caching = false

   # Print deprecation notices to the Rails logger.
   config.active_support.deprecation = :log

   # Raise an error on page load if there are pending migrations.
   config.active_record.migration_error = :page_load

   # Highlight code that triggered database queries in logs.
   config.active_record.verbose_query_logs = true

   # Debug mode disables concatenation and preprocessing of assets.
   # This option may cause significant delays in view rendering with a large
   # number of complex assets.
   config.assets.debug = true

   # Suppress logger output for asset requests.
   config.assets.quiet = true

   # Raises error for missing translations
   # config.action_view.raise_on_missing_translations = true

   # Use an evented file watcher to asynchronously detect changes in source code,
   # routes, locales, etc. This feature depends on the listen gem.
   config.file_watcher = ActiveSupport::EventedFileUpdateChecker

   config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

   config.active_job.queue_adapter = :sidekiq

   config.consider_all_requests_local = false
end
