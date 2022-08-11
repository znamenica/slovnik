# frozen_string_literal: true

Given("default User serializer") do
   expect(Object.constants).to include(:UserSerializer)
   @serializer ||= UserSerializer.new(User.first)
end

Then("the serializer is valid") do
   expect(@serializer.as_json).to eq({})
end
