class CreateDicta < ActiveRecord::Migration[7.0]
   def change
      enable_extension :btree_gin

      create_table :dicta do |t|
         t.string :text, index: :gin, null: false, comment: "Text of the dictum"
         t.references :language, index: true, null: false, foreign_key: true, comment: "Reference to the language"
         t.references :alphabeth, index: true, null: false, foreign_key: true, comment: "Reference to the alphabeth"
         t.references :dictumable, index: true, null: false, polymorphic: true, comment: "Polymorphic reference to a describable object"
         t.string :type, index: true, null: false, comment: "Model type for the dictum"
         t.tsvector :tsv, index: {using: :gin}

         t.timestamps

         t.index %w(text language_id alphabeth_id dictumable_id dictumable_type type), unique: true, name: 'index_unique_for_dictum'
      end

      reversible do |dir|
         dir.up do
            queries = [
               "UPDATE dicta
                SET tsv = setweight(to_tsvector(coalesce(text,'')), 'A')",
               "CREATE FUNCTION dicta_search_trigger() RETURNS trigger AS $$
                begin
                   new.tsv :=
                      setweight(to_tsvector(coalesce(new.text,'')), 'A');
                   return new;
                end
                $$ LANGUAGE plpgsql",
               "CREATE TRIGGER tsvectorupdate_for_dicta BEFORE INSERT OR UPDATE
                ON dicta FOR EACH ROW EXECUTE PROCEDURE dicta_search_trigger()"
            ]

            queries.each { |q| Dictum.connection.execute(q) }
         end

         dir.down do
            Dictum.connection.execute("DROP FUNCTION dicta_search_trigger() CASCADE")
         end
      end
   end
end
