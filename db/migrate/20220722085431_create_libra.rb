class CreateLibra < ActiveRecord::Migration[6.1]
   def change
      enable_extension :btree_gin

      create_table :libra do |t|
         t.text :text, null: false, index: true, comment: "Буко"
         t.string :title, null: false, index: true, comment: "Надпис бука"
         t.string :type, null: false, index: true, comment: "Взор бука"
         t.references :author, foreign_key: { to_table: :users }
         t.tsvector :tsv, index: {using: :gin}

         t.timestamps
      end

      reversible do |dir|
         dir.up do
            queries = [
               "UPDATE libra
                SET tsv = setweight(to_tsvector(coalesce(title,'')), 'A') ||
                          setweight(to_tsvector(coalesce(text,'')), 'D')",
               "CREATE FUNCTION libra_search_trigger() RETURNS trigger AS $$
                begin
                   new.tsv :=
                      setweight(to_tsvector(coalesce(new.title,'')), 'A') ||
                      setweight(to_tsvector(coalesce(new.text,'')), 'D');
                   return new;
                end
                $$ LANGUAGE plpgsql",
               "CREATE TRIGGER tsvectorupdate_for_libra BEFORE INSERT OR UPDATE
                ON libra FOR EACH ROW EXECUTE PROCEDURE libra_search_trigger()"
            ]

            queries.each { |q| Librum.connection.execute(q) }
         end

         dir.down do
            Librum.connection.execute("DROP FUNCTION libra_search_trigger() CASCADE")
         end
      end
   end
end
