Допустим('є дєл сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_piece = FactoryBot.create(:piece, attrs)
end

Если('є створение дєла сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = post("/p.json", {piece: attrs})
end

Если('послѣдня изнаходь дєла бѫдє яко:') do |yaml|
   expect(Piece.order(:created_at).last).to match_record_yaml(yaml)
end

Если('запытам одсланје дєла во изнаходь {string} сѫ даными:') do |path, table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @response = put(path, {piece: attrs})
end

То('дєл сѫ озом {string} не будє єствовати') do |id|
   piece = Piece.where(id: id).first
   expect(piece).to be_nil
end
