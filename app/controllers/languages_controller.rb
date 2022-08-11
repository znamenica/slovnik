# frozen_string_literal: true

class LanguagesController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_language, only: %i(show update destroy)

   respond_to :json

   # GET /languages
   def index
      @languages = Language.all.page(@page)

      render json: {
         list: @languages.jsonize(context),
         page: @page,
         total: @languages.total_count
      }
   end

   # GET /languages/1
   def show
      render json: @language.jsonize(context)
   end

   # POST /languages
   def create
      @language = Language.create(language_params)

      head :ok
   end

   # PATCH/PUT /languages/1
   def update
      @language.update!(language_params)

      head :ok
   end

   # DELETE /languages/1
   def destroy
      @language.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_language
         @language = Language.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def language_params
         params.require(:language).permit(:id, :code, meta: {})
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
