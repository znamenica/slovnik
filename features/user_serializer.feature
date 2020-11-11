Feature: User serializer

Scenario: Valid serializer for User
   Given default User model
   And default User serializer
   Then the serializer is valid
