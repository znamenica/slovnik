FactoryBot.define do
   factory :user do
      email { FFaker::Internet.safe_email }
      password { FFaker::Internet.password }
      password_confirmation { password }
      confirmed_at { Time.zone.now }

      after(:create) do |user, evaluator|
         user.confirm
      end
   end
end
