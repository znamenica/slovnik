FactoryBot.define do
   factory :dictionary do
      uri { FFaker::Internet.http_url }
      meta { {} }
   end
end
