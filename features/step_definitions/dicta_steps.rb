Допустим('є твьрꙉение сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_dictum = FactoryBot.create(:dictum, attrs)
end

Если('є створение твьрꙉенја сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/s.json", {dictum: attrs})
end

Если('послѣдня изнаходь твьрꙉенја бѫдє яко:') do |yaml|
   expect(Dictum.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје твьрꙉенја во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {dictum: attrs})
end

То('твьрꙉение сѫ озом {string} не будє єствовати') do |id|
   dictum = Dictum.where(id: id).first
   expect(dictum).to be_nil
end
