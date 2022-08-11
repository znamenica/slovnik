# frozen_string_literal: true

Допустим("є буко") do
   FactoryBot.create(:librum, author_id: current_user&.id)
end

Допустим("є буко сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   attrs["author_id"] = current_user.id if current_user
   @current_librum = FactoryBot.create(:librum, attrs)
end

Если("посєчям странку {string}") do |path|
   visit path
end

То("углѧдаѫ бука:") do |list|
   list.split("\n").each do |text|
      expect(page).to have_content_in_text_and_inputs(text)
   end
end

Если("правим свою назву бука яко {string}") do |text|
   fill_in "librum[title]", with: text
end

Если("правим своє дане бука яко {string}") do |text|
   fill_in "librum[text]", with: text
end

То("правке сѫчасна бука будꙛ єствовати яко:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }

   attrs.each do |prop, value|
      expect(current_librum.reload.send(prop)).to eq(value)
   end
end

Если("кушам изтрѣти странку {string}") do |path|
   page.driver.browser.process_and_follow_redirects(:delete, path)
end

То("бука сѫ озом {string} не будє єствовати") do |id|
   librum = Librum.where(id:).first
   expect(librum).to be_nil
end

Если("сꙛ правке сѫчасна бука сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   current_librum.update!(attrs)
end

Если("запытам изтрѣнје изнаходи {string}") do |path|
   @response = delete(path)
end

Если("запытам добыванје послѣднеи изнаходи буке") do
   @response = get("/library/#{Librum.last.id}.json")
end

Если("є створенје бука сѫ даными:") do |table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = post("/library.json", { librum: attrs })
end

Если("послѣдня изнаходь бука бѫдє яко:") do |doc_string|
   expect(Librum.order(:created_at).last).to match_record_yaml(doc_string)
end

Если("запытам одсланје бука во изнаходь {string} сѫ даными:") do |path, table|
   attrs = table.rows_hash.transform_values { |value| YAML.load(value) }
   @response = put(path, { librum: attrs })
end
