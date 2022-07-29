Допустим('є буко') do
   FactoryBot.create(:librum)
end

Допустим('є буко сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_librum = FactoryBot.create(:librum, attrs)
end

Если('посєчям странку {string}') do |path|
   visit path
end

То('углѧдаѫ бука:') do |list|
   list.split("\n").each do |text|
      expect(page).to have_content_in_text_and_inputs(text)
   end
end

Если('правим свою назву бука яко {string}') do |text|
   fill_in "librum[title]", with: text
end

Если('правим своє дане бука яко {string}') do |text|
   fill_in "librum[text]", with: text
end

То('правке сѫчасна бука будꙛ єствовати яко:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h

   attrs.each do |prop, value|
      expect(current_librum.reload.send(prop)).to eq(value)
   end
end

Если('кушам изтрѣти странку {string}') do |path|
   page.driver.browser.process_and_follow_redirects(:delete, path)
end

То('бука сѫ озом {string} не будє єствовати') do |id|
   librum = Librum.where(id: id).first
   expect(librum).to be_nil
end

Если('сꙛ правке сѫчасна бука сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   current_librum.update!(attrs)
end

Если('запытам изтрѣнје изнаходи {string}') do |path|
   delete(path)
end

Если('запытам добыванје послѣднеи изнаходи буке') do
   @response = get("/library/#{Librum.last.id}.json")
end

Если('є створенје бука сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/library.json", {librum: attrs})
end

Если('послѣдня изнаходь буке бѫдє яко:') do |doc_string|
   expect(Librum.order(:created_at).last).to match_record_yaml(doc_string)
end

