FactoryBot.define do
   factory :grammar do
      association :language
      association :alphabeth
      association :dictionary
      meta { {} }
   end
end
