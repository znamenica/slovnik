# frozen_string_literal: true

FactoryBot.define do
   factory :tag do
      kind { "article" }

      transient do
         title { Faker::Lorem.sentence }
      end

      after(:build) do |t, e|
         t.titles << build(:title, text: e.title)
      end
   end
end
