# frozen_string_literal: true

class Article < ApplicationRecord
   belongs_to :meaning
   belongs_to :grammar
   # belongs_to :tokens
   # belongs_to :tags
end
