# frozen_string_literal: true

FactoryBot.define do
   factory :account do
      sid { FFaker::Internet.safe_email }
      social { first_or_create(:social) }
      user

      #      after(:build) do |a, e|
      #         binding.pry
      #      end

      factory :email do
         social { first_or_create(:social, :email) }
      end
   end
end
