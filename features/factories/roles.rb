FactoryBot.define do
   factory :role do
      role { Faker::Lorem.word }

      factory :editing_role do
         role { 'editor' }
         for_librum

         trait :for_librum do
            association :resource, factory: :librum
         end
      end

      transient do
         users { [User.first].compact }
      end

      after(:build) do |r, e|
         r.users.concat(e.users)
      end
   end
end
