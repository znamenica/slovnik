# frozen_string_literal: true

FactoryBot.define do
   factory :dictionary do
      uri { FFaker::Internet.http_url }
      meta { {} }
   end
end
