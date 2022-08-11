# frozen_string_literal: true

class Grammar < ApplicationRecord
   belongs_to :language
   belongs_to :alphabeth
   belongs_to :dictionary
end
