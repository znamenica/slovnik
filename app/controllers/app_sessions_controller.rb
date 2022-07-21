class AppSessionsController < Devise::SessionsController
   include ApplicationCore

   before_action :authenticate_user!, except: [:create]
   protect_from_forgery with: :null_session, if: :json_request?
   protect_from_forgery with: :exception, unless: :json_request?
   respond_to :json

   rescue_from Exception, with: :render_exception

   def new
      respond_to do |format|
         format.html { super }
         format.json do
            headers['X-CSRF-Token'] = session[:_csrf_token] = form_authenticity_token
            render json: {}
         end
      end
   end

   def create
      respond_to do |format|
         format.html { super }
         format.json { login }
      end
   end

   def destroy
      respond_to do |format|
         format.html { super }
         format.json { logout }
      end
   end

   protected

   def login
      @user = User.find_for_database_authentication(email: params[:user][:email])
      raise ActiveRecord::RecordInvalid unless @user
      raise unless resource.valid_password?(params[:user][:password])

      sign_in(:user, @user)

      token = generate_access_token
      headers['X-Auth-Token'] = token
      render json: {email: resource.email, access_token: token, refresh_token: generate_refresh_token}, status: :ok
   end

   def logout
      token = Token.find_by!(code: auth_token, kind: :access)
      user = token.user
      sign_out(user)

      token.destroy!
      render json: {email: user.email}, status: :ok
   end

   def verify_signed_out_user
      json_request? || super
   end

   def generate_access_token
      _, token = Devise.token_generator.generate(User, :encrypted_password)
      Token.new(code: token, kind: :access, user: @user).save!

      token
   end

   def generate_refresh_token
      _, refresh_token = Devise.token_generator.generate(User, :email)
      Token.new(code: refresh_token, kind: :refresh, user: @user).save!

      refresh_token
   end
end
