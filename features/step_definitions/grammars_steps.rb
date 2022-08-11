# frozen_string_literal: true

Допустим("є граматика сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_grammar = FactoryBot.create(:grammar, attrs)
end

Если("є створение граматике сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/g.json", { grammar: attrs })
end

Если("послѣдня изнаходь граматике бѫдє яко:") do |yaml|
   expect(Grammar.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје граматике во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { grammar: attrs })
end

То("граматика сѫ озом {string} не будє єствовати") do |id|
   grammar = Grammar.where(id:).first
   expect(grammar).to be_nil
end
