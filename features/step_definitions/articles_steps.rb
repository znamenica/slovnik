Допустим('є чланък сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_article = FactoryBot.create(:article, attrs)
end

Если('є створение чланка сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/c.json", {article: attrs})
end

Если('послѣдня изнаходь чланка бѫдє яко:') do |yaml|
   expect(Article.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје чланка во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {article: attrs})
end

То('чланък сѫ озом {string} не будє єствовати') do |id|
   article = Article.where(id: id).first
   expect(article).to be_nil
end
