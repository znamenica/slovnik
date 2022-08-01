class CreateGrammars < ActiveRecord::Migration[6.1]
   def change
      create_table :grammars do |t|
         t.references :language, index: true, null: false, foreign_key: {on_delete: :restrict}, comment: 'Reference to the language'
         t.references :alphabeth, index: true, null: false, foreign_key: {on_delete: :restrict}, comment: 'Reference to the alphabeth'
         t.references :dictionary, index: true, null: false, foreign_key: {on_delete: :restrict}, comment: 'Reference to the dictionary record'
         t.jsonb :meta, index: true, null: false, default: {}, comment: 'Jsoned metadata hash for the grammar'

         t.timestamps

         t.index %i(language_id alphabeth_id dictionary_id), unique: true, name: 'index_grammars_on_language_alphabeth_dictionary'
      end
   end
end
