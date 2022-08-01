class AttitudesController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_attitude, only: %i(show update destroy)

   respond_to :json

   # GET /attitudes
   def index
      @attitudes = Attitude.all.page(@page)

      render json: {
         list: @attitudes.jsonize(context),
         page: @page,
         total: @attitudes.total_count
      }
   end

   # GET /attitudes/1
   def show
      render json: @attitude.jsonize(context)
   end

   # POST /attitudes
   def create
      @attitude = Attitude.create(attitude_params)

      head :ok
   end

   # PATCH/PUT /attitudes/1
   def update
      @attitude.update!(attitude_params)

      head :ok
   end

   # DELETE /attitudes/1
   def destroy
      @attitude.destroy

      head :ok
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_attitude
      @attitude = Attitude.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def attitude_params
      params.require(:attitude).permit(:id, :left_id, :right_id, :kind)
   end

   def context
      @context ||= { except: %i(created_at updated_at) }
   end
end
