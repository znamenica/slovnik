class DictaController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_dictum, only: %i(show update destroy)

   respond_to :json

   # GET /dicta
   def index
      @dicta = Dictum.all.page(@page)

      render json: {
         list: @dicta.jsonize(context),
         page: @page,
         total: @dicta.total_count
      }
   end

   # GET /dicta/1
   def show
      render json: @dictum.jsonize(context)
   end

   # POST /dicta
   def create
      @dictum = Dictum.create(dictum_params)

      head :ok
   end

   # PATCH/PUT /dicta/1
   def update
      @dictum.update!(dictum_params)

      head :ok
   end

   # DELETE /dicta/1
   def destroy
      @dictum.destroy

      head :ok
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_dictum
      @dictum = Dictum.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def dictum_params
      params.require(:dictum).permit(:id, :text, :language_id, :alphabeth_id, :dictumable_id, :dictumable_type, :type)
   end

   def context
      @context ||= { except: %i(created_at updated_at) }
   end
end
