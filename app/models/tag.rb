# frozen_string_literal: true

class Tag < ApplicationRecord
   enum :tag_kind, %w(language alphabeth dictionary grammar article meaning), default: "article"
end
