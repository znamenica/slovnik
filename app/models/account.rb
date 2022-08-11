# frozen_string_literal: true

class Account < ApplicationRecord
   belongs_to :social
   belongs_to :user
end
