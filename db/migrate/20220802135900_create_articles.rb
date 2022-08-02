class CreateArticles < ActiveRecord::Migration[6.1]
   def change
      create_enum :article_kind, %w(regular saying interpretation idiom)

      create_table :articles do |t|
         t.references :meaning, index: true, null: false, foreign_key: true, comment: 'Reference to its meaning'
         t.references :grammar, index: true, null: false, foreign_key: true, comment: 'Reference to the article grammar'
         t.bigint :token_ids, null: false, array: true, default: [], comment: 'Reference array to a token list'
         t.bigint :tag_ids, null: false, array: true, default: [], comment: 'Reference array to a tag list'
         t.string :separators, null: false, array: true, limit: 1, default: [], comment: 'Separator array used in the article'
         t.jsonb :meta, null: false, default: {}, comment: 'Jsoned metadata hash for the article'
         t.enum :kind, enum_type: :article_kind, null: false, index: true, default: 'regular', comment: 'Kind of the article are: Regular, Saying, Interpretation, or Idiom'

         t.timestamps
      end
   end
end
