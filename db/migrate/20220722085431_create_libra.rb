class CreateLibra < ActiveRecord::Migration[6.1]
   def change
      enable_extension :btree_gin

      create_table :libra do |t|
         t.text :text, null: false, index: true, comment: "Буко"
         t.string :title, null: false, index: {using: :gin}, comment: "Надпис бука"
         t.string :type, null: false, index: true, comment: "Взор бука"
         t.references :author, foreign_key: { to_table: :users }

         t.timestamps
      end
   end
end
