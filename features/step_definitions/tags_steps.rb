Допустим('є мѣта сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_tag = FactoryBot.create(:tag, attrs)
end

Если('є створение мѣте сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/t.json", {tag: attrs})
end

Если('послѣдня изнаходь мѣте бѫдє яко:') do |yaml|
   expect(Tag.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје мѣте во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {tag: attrs})
end

То('мѣта сѫ озом {string} не будє єствовати') do |id|
   tag = Tag.where(id: id).first
   expect(tag).to be_nil
end
