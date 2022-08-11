# frozen_string_literal: true

class ApplicationPolicy
   attr_reader :user

   def destroy?
      user.has_role? :admin
   end

   def update?
      user.has_role? :admin
   end

   def create?
      user.has_role? :admin
   end

   def initialize user, _record
      @user = user
   end
end
