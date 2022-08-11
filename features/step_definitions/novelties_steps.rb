Допустим('є новина') do
   FactoryBot.create(:novelty, author_id: current_user&.id)
end

Допустим('є новина сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   attrs['author_id'] = current_user.id if current_user
   @current_novelty = FactoryBot.create(:novelty, attrs)
end

То('углѧдаѫ новину:') do |list|
   list.split("\n").each do |text|
      expect(page).to have_content_in_text_and_inputs(text)
   end
end

То('правке сѫчасне новине будꙛ єствовати яко:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h

   attrs.each do |prop, value|
      expect(current_novelty.reload.send(prop)).to eq(value)
   end
end

То('новина сѫ озом {string} не будє єствовати') do |id|
   novelty = Novelty.where(id: id).first
   expect(novelty).to be_nil
end

Если('сꙛ правке сѫчасне новине сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   current_novelty.update!(attrs)
end

Если('правим свою назву новине яко {string}') do |text|
   fill_in "novelty[title]", with: text
end

Если('правим своє дане новине яко {string}') do |text|
   fill_in "novelty[text]", with: text
end

Если('запытам добыванје послѣднеи изнаходи новине') do
   @response = get("/news/#{Novelty.last.id}.json")
end

Если('є створенје новине сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/news.json", {novelty: attrs})
end

Если('послѣдня изнаходь новине бѫдє яко:') do |doc_string|
   expect(Novelty.order(:created_at).last).to match_record_yaml(doc_string)
end

Допустим('користник є правчиком') do
   current_user.add_role :editor
   expect(current_user).to have_role(:editor)
end

Если('запытам одсланје новине во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {novelty: attrs})
end

