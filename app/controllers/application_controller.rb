class ApplicationController < ActionController::Base
   include Pundit::Authorization

   protect_from_forgery with: :null_session, if: :json_request?
   protect_from_forgery with: :exception, unless: :json_request?
   before_action :authenticate_user!, except: [:home]
   before_action :set_paging, only: :index
   before_action :set_order, only: :index
   before_action :set_objects, only: :index

   rescue_from Exception, with: :render_exception
   # NOTE https://stackoverflow.com/a/48744792/446267
   rescue_from ActionController::UnknownFormat, with: ->{ render nothing: true }
   rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_record
   rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

   def home
   end

   protected

   def authenticate_user! opts = {}
      if json_request?
         @current_user = Token.find_by!(code: auth_token, kind: :access).user
      else
         super
      end
   rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("[#{e}]: #{e.message}\n\t#{e.backtrace.join("\n\t")}")

      render_unauthenticated
   end

   def auth_token
      params[:auth_token] || request.headers["X-AUTH-TOKEN"]
   end

   def current_user
      @current_user ||= super
   end

   def json_request?
      @json_request ||= request.format.json? || request.content_type == "application/json"
   end

   def render_unauthorized
      respond_to do |format|
         format.json { render json: {error: {message: 'Unauthorized'}}, status: 403 }
      end
   end

   def render_unauthenticated
      respond_to do |format|
         format.json { render json: {error: {message: 'Unauthenticated'}}, status: :unauthorized }
      end
   end

   def render_exception e
      Rails.logger.error("[#{e}]: #{e.message}\n\t#{e.backtrace.join("\n\t")}")

      respond_to do |format|
         format.json { render json: {error: {message: e.message}}, status: :internal_server_error }
      end
   end

   def render_invalid_record e
      Rails.logger.error("[#{e}]: #{e.message}\n\t#{e.backtrace.join("\n\t")}")

      respond_to do |format|
         format.json { render json: {error: {message: e.message}}, status: :locked }
      end
   end

   def set_order
      sort = params[:sort] || ""
      hash = sort.split(',').map {|x| (x.split(":") | ['asc'])[0..1] }.to_h

      order = hash.keys & model.attribute_names rescue []
      @order = order.map {|x| [x, hash[x]] }.to_h
   end

   def set_paging
      @page = params.fetch(:p, 1).to_i
      @per = params.fetch(:per, 25).to_i
   end

   def set_objects
      @objects = model.page(@page).per(@per).order(@order) rescue []
   end
end
