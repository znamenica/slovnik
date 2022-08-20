# frozen_string_literal: true

class ChangeLibraTags < ActiveRecord::Migration[6.1]
   disable_ddl_transaction!

   def change
      reversible do |dir|
         dir.up do
            execute("ALTER TYPE tag_kind ADD VALUE 'librum'")
         end
      end

      change_table :libra do |t|
         t.bigint :tag_ids, null: false, array: true, default: [], comment: "Набор озов мѣток яко линки"
      end
   end
end
