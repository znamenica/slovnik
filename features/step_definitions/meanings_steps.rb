# frozen_string_literal: true

Допустим("є значение сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_meaning = FactoryBot.create(:meaning, attrs)
end

Если("є створение значенја сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/m.json", { meaning: attrs })
end

Если("послѣдня изнаходь значенја бѫдє яко:") do |yaml|
   expect(Meaning.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје значенја во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { meaning: attrs })
end

То("значение сѫ озом {string} не будє єствовати") do |id|
   meaning = Meaning.where(id:).first
   expect(meaning).to be_nil
end
