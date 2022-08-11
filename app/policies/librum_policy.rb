# frozen_string_literal: true

class LibrumPolicy < ApplicationPolicy
   def destroy?
      super or user.has_role? :editor
   end

   def update?
      super or user.has_role? :editor
   end

   def create?
      super or user.has_role? :editor
   end
end
