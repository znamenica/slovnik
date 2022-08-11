# frozen_string_literal: true

Допустим("є чланък сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @current_article = FactoryBot.create(:article, attrs)
end

Если("є створение чланка сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/c.json", { article: attrs })
end

Если("послѣдня изнаходь чланка бѫдє яко:") do |yaml|
   expect(Article.order(:created_at).last).to match_record_yaml(yaml)
end

Если("запытам одсланје чланка во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { article: attrs })
end

То("чланък сѫ озом {string} не будє єствовати") do |id|
   article = Article.where(id:).first
   expect(article).to be_nil
end
