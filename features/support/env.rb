# require 'tiun'
require 'cucumber/rails'
require 'shoulda-matchers/cucumber'

FactoryBot.definition_file_paths = %w(features/factories)
FactoryBot.lint
World(FactoryBot::Syntax::Methods)
World(Rack::Test::Methods)

Shoulda::Matchers.configure do |config|
   config.integrate do |with|
      with.test_framework :cucumber
      with.library :rails
   end
end

RSpec::Matchers.define :match_response_json_yaml do |yaml|
   match do |response|
      hash = JSON.load(response.body)
      to_hash = YAML.load(yaml)
      deep_match(hash, to_hash)
   end
end

RSpec::Matchers.define :have_content_in_text_and_inputs do |text|
   match do |page|
      inputs = page.find_all("input", visible: false)

      inputs.any? { |input| /#{text}/ =~ input.value } ||
         page.text.split("\n").any? { |t| /#{text}/ =~ t }
   end
end

Before do
   # for route matchers
   @routes ||= ObjectSpace.each_object(ActionDispatch::Routing::RouteSet).to_a.select {|r| r.routes.count > 0 }.first
   # for minitest
   self.assertions ||= 0

   DatabaseRewinder.clean_all
end

After do
   DatabaseRewinder.clean
end

at_exit do
   DatabaseRewinder.clean
   # Tiun.rollback
end

#DatabaseCleaner.clean_with(:deletion) # clean once, now
#DatabaseCleaner.strategy = :transaction
#Cucumber::Rails::Database.javascript_strategy = :deletion
