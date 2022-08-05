FactoryBot.define do
   factory :social do
      uri { FFaker::Internet.http_url }
      kind { FFaker::Lorem.word }
      meta { {} }

      trait :email do
         uri { 'email://loc' }
         kind { 'email' }
      end

      trait :vk do
         uri { 'https://vk.com' }
         kind { 'vk' }
      end

      after(:build) do |s, e|
         s.titles << build(:title)
      end
   end
end
