# frozen_string_literal: true

class Librum < ApplicationRecord
   include TagIds

   resourcify
   # belongs_to :tags

   belongs_to :author, class_name: "User"

   default_scope { where(type: "Librum") }

   validates_presence_of :abstract
   validates :cover_uri, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
