# frozen_string_literal: true

# require 'tiun'
require "pry"
require "cucumber/rails"
require "shoulda-matchers/cucumber"
require "database_cleaner/active_record"

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

RSpec::Matchers.define :match_record_yaml do |yaml|
   match do |record|
      deep_match(record.attributes, YAML.load(yaml))
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
   @routes ||= ObjectSpace.each_object(ActionDispatch::Routing::RouteSet).to_a.find { |r| r.routes.count > 0 }
   # for minitest
   self.assertions ||= 0

   Redis.current.flushall
   DatabaseCleaner.start
end

After do
   DatabaseCleaner.clean
end

DatabaseCleaner[:active_record].strategy = :transaction
