FactoryBot.define do
   factory :dictum do
      text { Faker::Lorem.sentence }
      association :language
      association :alphabeth
      type { "Sentence" }
      for_article

      trait :for_article do
         association :dictumable, factory: :article
      end

      trait :for_meaning do
         association :dictumable, factory: :meaning
      end
   end
end
