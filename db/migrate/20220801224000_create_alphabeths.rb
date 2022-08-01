class CreateAlphabeths < ActiveRecord::Migration[6.1]
   def change
      create_table :alphabeths do |t|
         t.string :code, index: {unique: true}, limit: 3, null: false, comment: 'Three letter sized code of the alphabeth'
         t.jsonb :meta, index: true, null: false, default: {}, comment: 'Jsoned metadata hash for the alphabeth'

         t.timestamps
      end
   end
end
