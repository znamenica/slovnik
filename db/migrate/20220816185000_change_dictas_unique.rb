# frozen_string_literal: true

class ChangeDictasUnique < ActiveRecord::Migration[7.0]
   def change
      change_table :dicta do |t|
         t.remove_index %w(text language_id alphabeth_id dictumable_id dictumable_type type), unique: true,
            name: "index_unique_for_dictum"

         t.index %w(text language_id alphabeth_id dictumable_id dictumable_type type kind), unique: true,
            name: "index_unique_for_dictum"
      end
   end
end
