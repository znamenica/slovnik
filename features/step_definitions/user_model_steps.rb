Given("default User model") do
   User.create(names: "Vasja")
end

Then("the model is valid") do
   expect(User.first).to validate_presence_of(:names)
end
