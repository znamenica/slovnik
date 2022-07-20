module Spec
   def described_class
      kls = yield if block_given?
      @described_class = kls || @described_class
   end

   def is_expected
      expect(subject)
   end

   def subject
      Class === described_class ? described_class.new : described_class
   end

   def json_body
      JSON.load(@response.body)
   end

   def deep_match obj, to_obj
      raise if obj.class != to_obj.class

      case to_obj
      when Array
         array_match(obj, to_obj)
      when Hash
         hash_match(obj, to_obj)
      else
         raise if obj != to_obj
      end

      true
   end

   def array_match array, to_array
      to_array.map.with_index do |to_val, index|
         deep_match(array[index], to_val)
      end.any?
   end

   def hash_match hash, to_hash
      to_hash.map do |(to_key, to_val)|
         deep_match(hash[to_key], to_val)
      end.any?
   end
end

module Support
   def sign_up options = {}
      current_user_build

      visit '/users/sign_up'
      fill_in "user[email]", with: options[:email] || current_user.email
      fill_in "user[password]", with: options[:password] || current_user.password
      fill_in "user[password_confirmation]", with: options[:password_confirmation] || current_user.password_confirmation
      click_button "Sign up"
   end

   def sign_out
      delete '/users/sign_out'
   end

   def sign_in options = {}
      visit '/users/sign_in'
      fill_in "user[email]", with: options[:email] || current_user.email
      fill_in "user[password]", with: options[:password] || current_user.password
      click_button "Log in"
   end

   def form_fill_in options = {}
      @options = options

      visit '/users/edit'
      fill_in "user[email]", with: options[:email] || current_user.email
      fill_in "user[current_password]", with: options[:current_password] || current_user.password
      fill_in "user[password]", with: options[:password]
      fill_in "user[password_confirmation]", with: options[:password]
   end

   def current_user
      @current_user ||= FactoryBot.create(:user)
   end

   def current_user_build
      @current_user ||= FactoryBot.build(:user)
   end

   def current_user_with options
      @current_user ||= FactoryBot.build(:user, options)
   end

   def drop_current_user
      @current_user = FactoryBot.build(:user)
   end
end

World(Spec)
World(Support)
