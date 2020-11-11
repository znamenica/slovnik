Given("default Users controller") do
   described_class do
      V1::UsersController
   end
end

Then("all default routes are presented") do
   is_expected.to route(:get, '/v1/users/1.json').to("v1/users#show", id: 1)
end
