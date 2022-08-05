Допустим('є социалка сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_social = FactoryBot.create(:social, attrs)
end

Если('є створение социалке сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/so.json", {social: attrs})
end

Если('послѣдня изнаходь социалке бѫдє яко:') do |yaml|
   expect(Social.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје социалке во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {social: attrs})
end

То('социалка сѫ озом {string} не будє єствовати') do |id|
   social = Social.where(id: id).first
   expect(social).to be_nil
end
