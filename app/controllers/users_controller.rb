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

   # PATCH/PUT /me.json
   def upme
      current_user.update!(user_params)

      respond_to do |format|
         format.json { head :ok }
         format.html { redirect_to @novelty, notice: 'Current user was successfully updated.' }
      end
   rescue
      respond_to do |format|
         format.json { head :locked }
         format.html { render :edit }
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_user
      @user = User.find(params[:id])
   end

   def context
      @context ||= { locales: @locales, only: %i(id accounts names),
                     accounts: {only: %i(id social_id user_id sid)},
                     names: {except: %i(tsv created_at updated_at) } }

   end

   def set_locales
      @locales ||= :ru
   end

   def user_params
      params.require(:user).permit(:id, :password, :password_confirmation,
         accounts_attributes: [:id, :sid, :social_id, :_destroy],
         names_attributes: [:id, :text, :kind, :language_id, :alphabeth_id, :_destroy])
   end
end
