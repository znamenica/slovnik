FactoryBot.define do
   factory :language do
      code { FFaker::InternetSE.user_name_random[0..2] }
      meta { {} }
   end
end
