FactoryBot.define do
   factory :dictionary do
      uri { FFaker::Internet.uri }
      meta { {} }
   end
end
