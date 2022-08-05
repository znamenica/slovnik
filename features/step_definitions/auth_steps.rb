Допустим('є користник сѫ прѣзвищем {string}') do |nickname|
   @current_user = FactoryBot.create(:user, nickname: nickname)
end

Допустим('є користник сѫ прѣзвищем {string} и токеном') do |nickname|
   @current_user = FactoryBot.create(:user, nickname: nickname)
   @token = FactoryBot.create(:token, user: @current_user)
   header 'X-Auth-Token', @token.code
end

Допустим('є токен для користника {string}') do |token|
   @token = FactoryBot.create(:token, user: current_user)
   header 'X-Auth-Token', @token.code
end

Допустим('є користник сѫ токеном и даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_user = FactoryBot.create(:user, attrs)
   @token = FactoryBot.create(:token, user: @current_user)
   header 'X-Auth-Token', @token.code
end

То('добѫдѫ кодъ поврата {string}') do |kod|
   expect(@response&.status || page.status_code).to eql(kod.to_i)
end

#Если('запытам кратке имене') do
#   header 'Accept', 'application/json'
#   header 'Content-Type', 'application/json'
#   @response = get('/short_names.json', session: {'jwt': @token})
#end
#
Если('сдѣлам {string} запыт да адресе {string} со параметром {string}') do |proto, address, parms|
   @response = send(proto.downcase, address, parms)
end

То('примѣтим пресмѣренје на адрес {string} сѫ погрѣшкоꙛ {string}') do |_address, error|
   expect(@response&.status || page.status_code).to eq(302)
   expect(@response.body).to match(/dashboard\?error=#{error}/)
end

Если('запытам добыванје из изнаходи {string}') do |address|
   #@response = get(address, session: {'jwt': @token})
   @response = get(address)
end

Если('нєсм приявєным') do
   delete '/users/sign_out'
end

Если('приявям сѧ сѫ завѣрєными даными') do
   sign_in
end

То('углѧдаѫ букє {string}') do |text|
   expect(page).to have_content(text)
end

То('углѧдаѫ букє мыла користника') do
   expect(page).to have_content(current_user.email)
end

Если('приявям сѧ сѫ невѣрным мылом') do
   sign_in(email: 'invalid')
end

Если('приявям сѧ сѫ невѣрноѫ лозинкоѫ') do
   sign_in(password: 'invalid')
end

Допустим('не є користника') do
   current_user_build
end

Допустим('єсм приявєным') do
   sign_in
end

Если('одꙇявям сѧ') do
   page.driver.browser.process_and_follow_redirects(:delete, "/users/sign_out")
end

Если('вꙇявям сѧ сѫ вѣрными данными') do
   sign_up
end

То('сѫчасьн користник будє єствовати') do
   expect(User.find_by_email(current_user.email)).to be_persisted
end

Если('вꙇявям сѧ сѫ невѣрным мылом') do
   sign_up(email: 'invalid')
end

То('сѫчасна користника не будє єствовати') do
   current_user.reload rescue nil
   expect(current_user).to_not be_persisted
end

Если('вꙇявям сѧ сѫ пустоѫ лозинкоѫ') do
   sign_up(password: '')
end

Если('вꙇявям сѧ без потвьрꙉенја лозинке') do
   sign_up(password_confirmation: '')
end

Если('вꙇявям сѧ сѫ невѣрным потвьрꙉенјем лозинке') do
   sign_up(password_confirmation: 'invalid')
end

Если('правим своє имѧ') do
   form_fill_in
end

Если('запишем форму правке') do
   click_button "Update"
end

То('правке сѫчасна користника будꙛ єствовати') do
   current_user.reload.confirm
   @options.each do |name, value|
      expect(current_user.send(name)).to eq(value)
   end
end

Если('правим своє мыле') do
   form_fill_in(email: FFaker::Internet.safe_email)
end

Если('правим своє мыле сѫ невѣрным мылом') do
   form_fill_in(email: 'invalid')
end

То('правок сѫчасна користника не будє єствовати') do
   current_user.reload.confirm
   @options.each do |name, value|
      expect(current_user.send(name)).to_not eq(value)
   end
end

Если('правим своѫ лозинкѫ') do
   form_fill_in(password: FFaker::Internet.password)
end

Если('правим своѫ лозинкѫ сѫ пустым потвьрꙉенјем') do
   form_fill_in(password_confirmation: '')
end

Если('правим своѫ лозинкѫ сѫ невѣрным потвьрꙉенјем') do
   form_fill_in(password_confirmation: 'invalid')
end

Если('Обглѧдам користиников') do
   visit '/users'
end

То('углѧдаѫ имѧ сѫчаснаго користника') do
   expect(page).to have_content(current_user.firstname)
end

То('добѫдѫ вывод:') do |doc_string|   # match_response_schema
   # binding.pry
   expect(@response).to match_response_json_yaml(doc_string)
end

Допустим('є користник сѫ даными:') do |table|
   attrs = table.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
   @current_user = FactoryBot.create(:user, attrs)
end

Если('правим своє мыле без текучеи лозинке') do
   form_fill_in(email: FFaker::Internet.safe_email, current_password: '')
end

То('правка лозинке сѫчасна користника будє єствовати') do
   current_user.reload.confirm
   expect(current_user.valid_password?(@options[:password])).to be_truthy
end

То('правке лозинке сѫчасна користника не будє єствовати') do
   current_user.reload.confirm
   expect(current_user.valid_password?(current_user.password)).to be_truthy
   expect(current_user.valid_password?(@options[:password])).to be_falsey
end

То('уже нєсм приявеным') do
   response = get('/me.json')
   expect(response.status).to eq(401)
end

Если('запытам одстраненје изнаходи {string}') do |path|
   @response = delete(path)
end

Если('запытам одсланје користника во изнаходь {string} сѫ даными:') do |path, data_in|
   attrs =
      if data_in.is_a?(String)
         YAML.load(data_in)
      else
         data_in.rows_hash.map { |attr, value| [ attr, YAML.load(value) ] }.to_h
      end

   current_user.password = attrs['password'] if attrs['password']
   @response = post(path, {user: attrs})
end

Если('запытам добыванје новъ токенъ') do
   @response = post('/users/sign_in.json', user: {email: current_user.email, password: current_user.password})
   json = JSON.load(@response.body)
   header 'X-Auth-Token', json["access_token"]
end

То('добѫдѫ новъ токенъ') do
   response = get('/me.json')
   expect(response.status).to eq(200)
end
