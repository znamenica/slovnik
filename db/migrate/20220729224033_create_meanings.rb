class CreateMeanings < ActiveRecord::Migration[6.1]
   def change
      create_table :meanings do |t|
         t.integer :tag_ids, default: [], null: false, array: true
         t.integer :article_ids, default: [], null: false, array: true

         t.timestamps
      end
   end
end
