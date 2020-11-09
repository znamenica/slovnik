require 'tiun'
require 'cucumber/rails'
require 'shoulda-matchers/cucumber'

Shoulda::Matchers.configure do |config|
   config.integrate do |with|
      with.test_framework :cucumber
      with.library :rails
   end
end

Before do
   DatabaseRewinder.clean_all
end

After do
   DatabaseRewinder.clean
end

at_exit do
   DatabaseRewinder.clean
   Tiun.rollback
end

#DatabaseCleaner.clean_with(:deletion) # clean once, now
#DatabaseCleaner.strategy = :transaction
#Cucumber::Rails::Database.javascript_strategy = :deletion
