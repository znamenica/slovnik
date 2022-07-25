class UsersController < ApplicationController
   before_action :set_user, only: [:show]

   def index
      @users = User.all.page(params[:p])

      respond_to do |format|
         format.json do
            render plain: {
               list: @users.as_json,#.jsonize(context),
               page: @page,
               total: @users.total_count
            }.to_json#(context)
         end
      end
   end

   # GET /users/1
   def show
      respond_to do |format|
         format.json do
            render plain:
               @user.as_json #.jsonize(context)
            .to_json#(context)
         end
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_user
      @user = User.find(params[:id])
   end
end
