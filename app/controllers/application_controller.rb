class ApplicationController < ActionController::Base
   include ApplicationCore

   protect_from_forgery with: :exception
   before_action :authenticate_user!, except: [:home]

   rescue_from Exception, with: :render_exception
   # NOTE https://stackoverflow.com/a/48744792/446267
   rescue_from ActionController::UnknownFormat, with: ->{ render nothing: true }

   def home
   end
end
