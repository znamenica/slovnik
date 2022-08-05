class CreateAccounts < ActiveRecord::Migration[7.0]
   def change
      create_table :accounts do |t|
         t.references :social, null: false, index: true, foreign_key: true, comment: "References to social"
         t.references :user, null: false, index: true, foreign_key: true, comment: "References to user"
         t.string :sid, null: false, index: true, comment: "User identifier in the specified social"

         t.timestamps

         t.index %i(social_id sid), unique: true
      end
   end
end
