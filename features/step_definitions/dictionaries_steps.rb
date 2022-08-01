Допустим('є словник сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_dictionary = FactoryBot.create(:dictionary, attrs)
end

Если('є створение словника сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/d.json", {dictionary: attrs})
end

Если('послѣдня изнаходь словника бѫдє яко:') do |yaml|
   expect(Dictionary.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје словника во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {dictionary: attrs})
end

То('словник сѫ озом {string} не будє єствовати') do |id|
   dictionary = Dictionary.where(id: id).first
   expect(dictionary).to be_nil
end
