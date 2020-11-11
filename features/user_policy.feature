Feature: User policy

Scenario: Valid policy of User
   Given default User model
   And default User policy
   Then the policy is valid
