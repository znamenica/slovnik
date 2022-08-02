FactoryBot.define do
   factory :article do
      association :meaning
      association :grammar
      token_ids { [] }
      tag_ids { [] }
      separators { [] }
      meta { {} }
      kind { 'regular' }
   end
end
