FactoryBot.define do
   factory :librum do
      type { "Librum" }
      title { Faker::Lorem.sentence }
      text { Faker::Lorem.paragraph }
      author { association :user }
   end

   factory :novelty, parent: :librum do
      type { "Novelty" }
   end
end
