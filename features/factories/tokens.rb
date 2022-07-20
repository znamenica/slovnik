FactoryBot.define do
   factory :token do
      code { FFaker::Internet.safe_email }
      kind { :access }
      expires_at { Time.zone.now + 6.months}
      association :user

      after(:build) do |token, evaluator|
         token.user = evaluator.user
      end
   end
end
