class CreateAttitudes < ActiveRecord::Migration[7.0]
#   def up
#     execute <<-SQL
#        CREATE TYPE attitude_kind AS ENUM ('Synonim', 'Antonim');
#     SQL
#   end
#
#   def down
#     execute <<-SQL
#        DROP TYPE attitude_kind;
#     SQL
#   end
#
   def change
      create_enum :attitude_kind, %w(synonim antonim)

      create_table :attitudes do |t|
         t.references :left, references: :meaning, null: false, index: true, foreign_key: {to_table: :meanings, on_delete: :restrict}, comment: "Left operand for the attitude"
         t.references :right, references: :meaning, null: false, index: true, foreign_key: {to_table: :meanings, on_delete: :restrict}, comment: "Right operand for the attitude"
         t.enum :kind, enum_type: "attitude_kind", null: false, index: true, comment: "Attitude kind is one of Synonim, or Antonim"

         t.timestamps

         t.index %w(left_id right_id kind), unique: true
      end
   end
end
