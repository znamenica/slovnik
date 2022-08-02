class CreatePieces < ActiveRecord::Migration[7.0]
  def change
    create_table :pieces do |t|
      t.bigint :language_ids, null: false, array: true, index: true, default: [], comment: "Reference array to languages"
      t.string :text, null: false, index: true, comment: "Text of the piece without a spaces"
      t.jsonb :meta, null: false, default: {}, index: true, comment: "Jsoned metadata hash for the piece"

      t.timestamps

      t.index %i(language_ids text), unique: true
    end
  end
end
