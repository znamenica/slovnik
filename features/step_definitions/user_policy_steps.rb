Given("default User policy") do
   expect(Object.constants).to include(:UserPolicy)
   @policy ||= UserPolicy.new(User.first, User.first)
end

Then("the policy is valid") do
   expect(@policy).to be_valid
end
