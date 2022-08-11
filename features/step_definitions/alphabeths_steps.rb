# frozen_string_literal: true

Допустим("є азбука сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_alphabeth = FactoryBot.create(:alphabeth, attrs)
end

Если("є створение азбуке сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/a.json", { alphabeth: attrs })
end

Если("послѣдня изнаходь азбуке бѫдє яко:") do |yaml|
   expect(Alphabeth.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје азбуке во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { alphabeth: attrs })
end

То("азбука сѫ озом {string} не будє єствовати") do |id|
   alphabeth = Alphabeth.where(id:).first
   expect(alphabeth).to be_nil
end
