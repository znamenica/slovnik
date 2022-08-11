# frozen_string_literal: true

Допустим("є словник сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_dictionary = FactoryBot.create(:dictionary, attrs)
end

Если("є створение словника сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/d.json", { dictionary: attrs })
end

Если("послѣдня изнаходь словника бѫдє яко:") do |yaml|
   expect(Dictionary.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје словника во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { dictionary: attrs })
end

То("словник сѫ озом {string} не будє єствовати") do |id|
   dictionary = Dictionary.where(id:).first
   expect(dictionary).to be_nil
end
