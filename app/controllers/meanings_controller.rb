class MeaningsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_meaning, only: %i(show update destroy)

   respond_to :json

   # GET /meanings
   def index
      @meanings = Meaning.all.page(@page)

      render json: {
         list: @meanings.jsonize(context),
         page: @page,
         total: @meanings.total_count
      }
   end

   # GET /meanings/1
   def show
      render json: @meaning.jsonize(context)
   end

   # POST /meanings
   def create
      @meaning = Meaning.create(meaning_params)

      head :ok
   end

   # PATCH/PUT /meanings/1
   def update
      @meaning.update!(meaning_params)

      head :ok
   end

   # DELETE /meanings/1
   def destroy
      @meaning.destroy

      head :ok
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_meaning
      @meaning = Meaning.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def meaning_params
      params.require(:meaning).permit(:id, tag_ids: [], article_ids: [])
   end

   def context
      @context ||= { except: %i(created_at updated_at) }
   end
end
