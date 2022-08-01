FactoryBot.define do
   factory :language do
      code { FFaker::Locale.code }
      meta { {} }
   end
end
