Допустим('є учетка сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_account = FactoryBot.create(:account, attrs)
end

Если('є створение учетък сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/ac.json", {account: attrs})
end

Если('послѣдня изнаходь учетке бѫдє яко:') do |yaml|
   expect(Account.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје учетке во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {account: attrs})
end

То('учетке сѫ озом {string} не будє єствовати') do |id|
   account = Account.where(id: id).first
   expect(account).to be_nil
end
