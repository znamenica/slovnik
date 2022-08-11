# frozen_string_literal: true

FactoryBot.define do
   factory :language do
      code { rand(2**256).to_s(36)[0..2] }
      meta { {} }
   end
end
