class CreateTokens < ActiveRecord::Migration[6.1]
   def change
      create_table :tokens do |t|
         t.string :code, null: false, index: { unique: true }
         t.string :kind, null: false, index: true
         t.references :user, null: false, foreign_key: true
         t.datetime :expires_at, index: true

         t.timestamps
      end
   end
end
