class UsersController < ApplicationController
   before_action :set_user, only: [:show]
   before_action :set_locales

   # GET /users.json
   def index
      @users = User.all.page(params[:p])

      respond_to do |format|
         format.json do
            render plain: {
               list: @users.jsonize(context),
               page: @page,
               total: @users.total_count
            }.to_json
         end
      end
   end

   # GET /users/1.json
   def show
      respond_to do |format|
         format.json { render :show, json: @user.jsonize(context) }
      end
   end

   # GET /me.json
   def me
      respond_to do |format|
         format.json { render :show, json: current_user.jsonize(context) }
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_user
      @user = User.find(params[:id])
   end

   def context
      @context ||= { locales: @locales, only: %i(id email firstname midname lastname nickname) }
   end

   def set_locales
      @locales ||= :ru
   end
end
