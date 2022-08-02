FactoryBot.define do
   factory :piece do
      language_ids { [] }
      text { Faker::Lorem.word }
      meta { {} }
   end
end
