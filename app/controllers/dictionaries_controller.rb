# frozen_string_literal: true

class DictionariesController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_dictionary, only: %i(show update destroy)

   respond_to :json

   # GET /dictionaries
   def index
      @dictionaries = Dictionary.all.page(@page)

      render json: {
         list: @dictionaries.jsonize(context),
         page: @page,
         total: @dictionaries.total_count
      }
   end

   # GET /dictionaries/1
   def show
      render json: @dictionary.jsonize(context)
   end

   # POST /dictionaries
   def create
      @dictionary = Dictionary.create(dictionary_params)

      head :ok
   end

   # PATCH/PUT /dictionaries/1
   def update
      @dictionary.update!(dictionary_params)

      head :ok
   end

   # DELETE /dictionaries/1
   def destroy
      @dictionary.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_dictionary
         @dictionary = Dictionary.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def dictionary_params
         params.require(:dictionary).permit(:id, :uri, meta: {})
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
