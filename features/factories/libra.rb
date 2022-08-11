# frozen_string_literal: true

FactoryBot.define do
   factory :librum do
      type { "Librum" }
      title { Faker::Lorem.sentence }
      text { Faker::Lorem.paragraph }
      author { association :user }
   end

   factory :novelty, parent: :librum, class: "Novelty" do
      type { "Novelty" }
   end
end
