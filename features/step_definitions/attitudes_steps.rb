# frozen_string_literal: true

Допустим("є одношение сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_attitude = FactoryBot.create(:attitude, attrs)
end

Если("є створение одношенја сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/at.json", { attitude: attrs })
end

Если("послѣдня изнаходь одношенја бѫдє яко:") do |yaml|
   expect(Attitude.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје одношенја во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { attitude: attrs })
end

То("одношение сѫ озом {string} не будє єствовати") do |id|
   attitude = Attitude.where(id:).first
   expect(attitude).to be_nil
end
