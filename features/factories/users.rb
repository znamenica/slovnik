FactoryBot.define do
   factory :user do
      password { FFaker::Internet.password }
      password_confirmation { password }
      confirmed_at { Time.zone.now }

      transient do
         email { FFaker::Internet.safe_email }
         firstname { FFaker::Name.first_name }
         nickname { FFaker::Name.first_name }
      end

      after(:build) do |user, e|
         user.accounts << build(:email, user: user, sid: e.email)
         user.names << build(:name, :first_name, dictumable: user, text: e.firstname)
         user.names << build(:name, :nick_name, dictumable: user, text: e.nickname)
      end

      after(:create) do |user, e|
         user.confirm
      end

      factory :admin do
         after(:build) do |user, e|
            user.add_role :admin
         end
      end

      factory :editor do
         transient do
            resource { factory :librum }
         end

         after(:build) do |user, e|
            user.add_role :editor, e.resource
         end
      end
   end
end
