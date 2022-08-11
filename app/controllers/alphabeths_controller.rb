# frozen_string_literal: true

class AlphabethsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_alphabeth, only: %i(show update destroy)

   respond_to :json

   # GET /alphabeths
   def index
      @alphabeths = Alphabeth.all.page(@page)

      render json: {
         list: @alphabeths.jsonize(context),
         page: @page,
         total: @alphabeths.total_count
      }
   end

   # GET /alphabeths/1
   def show
      render json: @alphabeth.jsonize(context)
   end

   # POST /alphabeths
   def create
      @alphabeth = Alphabeth.create(alphabeth_params)

      head :ok
   end

   # PATCH/PUT /alphabeths/1
   def update
      @alphabeth.update!(alphabeth_params)

      head :ok
   end

   # DELETE /alphabeths/1
   def destroy
      @alphabeth.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_alphabeth
         @alphabeth = Alphabeth.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def alphabeth_params
         params.require(:alphabeth).permit(:id, :code, meta: {})
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
