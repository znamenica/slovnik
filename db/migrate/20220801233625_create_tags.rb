class CreateTags < ActiveRecord::Migration[7.0]
   def change
      create_enum :tag_kind, %w(language alphabeth dictionary grammar article meaning)

      create_table :tags do |t|
         t.enum :kind, enum_type: "tag_kind", null: false, index: true, comment: "Tag kind is one of six kinds"

         t.timestamps
      end
   end
end
