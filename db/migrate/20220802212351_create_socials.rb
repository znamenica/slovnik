# frozen_string_literal: true

class CreateSocials < ActiveRecord::Migration[7.0]
   def change
      create_table :socials do |t|
         t.string :uri, index: true, null: false, comment: "Base URI of the social"
         t.jsonb :meta, index: true, null: false, default: {}, comment: "Jsoned metadata"
         t.string :kind, index: { unique: true }, null: false, comment: "One word kind of the social"

         t.timestamps
      end
   end
end
