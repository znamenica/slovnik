# frozen_string_literal: true

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

      factory :title, class: :Title do
         type { "Title" }
      end

      factory :name, class: :Name do
         type { "Name" }

         trait :first_name do
            kind { "first_name" }
         end

         trait :nick_name do
            kind { "nick_name" }
         end
      end
   end
end
