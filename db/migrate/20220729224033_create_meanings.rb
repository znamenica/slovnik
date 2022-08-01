class CreateMeanings < ActiveRecord::Migration[6.1]
   def change
      create_table :meanings do |t|
         t.integer_array :tag_ids, default: [], null: false
         t.integer_array :article_ids, default: [], null: false

         t.timestamps
      end
   end
end
