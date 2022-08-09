Sentry.init do |config|
   config.dsn = ENV["SENTRY_DSN"]
   config.breadcrumbs_logger = [:sentry_logger, :active_support_logger, :http_logger]

   # Set traces_sample_rate to 1.0 to capture 100%
   # of transactions for performance monitoring.
   # We recommend adjusting this value in production.
   config.traces_sampler = lambda do |context|
      0.5
   end
end if Rails.env.production?
