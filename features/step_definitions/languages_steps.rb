# frozen_string_literal: true

Допустим("є ѧзык сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_language = FactoryBot.create(:language, attrs)
end

Если("є створение ѧзыка сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/l.json", { language: attrs })
end

Если("послѣдня изнаходь ѧзыка бѫдє яко:") do |yaml|
   expect(Language.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје ѧзыка во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { language: attrs })
end

То("ѧзык сѫ озом {string} не будє єствовати") do |id|
   language = Language.where(id:).first
   expect(language).to be_nil
end
