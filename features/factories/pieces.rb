# frozen_string_literal: true

FactoryBot.define do
   factory :piece do
      language_ids { [] }
      text { Faker::Lorem.word }
      meta { {} }
   end
end
