FactoryBot.define do
   factory :alphabeth do
      code { rand(2**256).to_s(36)[0..2] }
      meta { {} }
   end
end
