# frozen_string_literal: true

class Social < ApplicationRecord
   has_many :descriptions, as: :dictumable
   has_many :titles, as: :dictumable
end
