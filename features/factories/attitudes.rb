# frozen_string_literal: true

FactoryBot.define do
   factory :attitude do
      left { association :meaning }
      right { association :meaning }
      kind { "synonim" }
   end
end
