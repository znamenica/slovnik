# frozen_string_literal: true

class Tag < ApplicationRecord
   enum :tag_kind, %w(language alphabeth dictionary grammar article meaning librum), default: "article"

   has_many :descriptions, as: :dictumable
   has_many :titles, as: :dictumable

   scope :by_name, -> (names) do
      joins(:titles).where(dicta: { text: names })
   end

   validates_presence_of :titles

   accepts_nested_attributes_for :titles, reject_if: :all_blank, allow_destroy: true
   accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
end
