class CreateDictionaries < ActiveRecord::Migration[6.1]
   def change
      create_table :dictionaries do |t|
         t.string :uri, index: {unique: true}, null: false, comment: 'Base URI to the dictionary'
         t.jsonb :meta, index: true, null: false, default: {}, comment: 'Jsoned metadata hash for the dictionary'

         t.timestamps
      end
   end
end
