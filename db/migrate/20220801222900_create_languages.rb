class CreateLanguages < ActiveRecord::Migration[6.1]
   def change
      create_table :languages do |t|
         t.string :code, index: {unique: true}, limit: 3, null: false, comment: 'Three letter sized code of the language'
         t.jsonb :meta, index: true, null: false, default: {}, comment: 'Jsoned metadata hash for the language'

         t.timestamps
      end
   end
end
