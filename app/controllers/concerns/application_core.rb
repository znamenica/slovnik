module ApplicationCore
   def authenticate_user! opts = {}
      if json_request?
         @current_user = Token.find_by!(code: auth_token, kind: :access).user
      else
         super
      end
   rescue ActiveRecord::RecordNotFound => e
      render_unauthorized
   end

   def auth_token
      params[:auth_token] || request.headers["X-AUTH-TOKEN"]
   end

   def current_user
      @current_user || super
   end

   def json_request?
      request.format.json? || request.content_type == "application/json"
   end

   def render_unauthorized
      respond_to do |format|
         format.html { render "home", status: :internal_server_error }
         format.json { render json: {error: {message: 'Unauthorized'}, status: :unauthorized }}
      end
   end

   def render_exception e
      Rails.logger.error("[#{e}]: #{e.message}\n\t#{e.backtrace.join("\n\t")}")

      respond_to do |format|
         format.html { render "home", status: :internal_server_error }
         format.json { render json: {error: {message: e.message}}, status: :internal_server_error }
      end
   end
end
