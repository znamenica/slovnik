FactoryBot.define do
   factory :alphabeth do
      code { FFaker::Locale.code }
      meta { {} }
   end
end
