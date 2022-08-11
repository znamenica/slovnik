# frozen_string_literal: true

class Attitude < ApplicationRecord
   belongs_to :left, class_name: "Meaning"
   belongs_to :right, class_name: "Meaning"
   enum :attitude_kind, %w(synonim antonim), default: "synonim"
end
