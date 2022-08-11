# frozen_string_literal: true

class NoveltiesController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show]

   before_action :set_novelty, only: %i(show update destroy)
   before_action :init_novelty, only: :create
   before_action :authorize_novelty, only: %i(create update destroy)

   # GET /novelties
   def index
      respond_to do |format|
         format.json do
            render plain: {
               list: @objects.jsonize(context),
               page: @page,
               per: @per,
               total: @objects.total_count
            }.to_json
         end
      end
   end

   # GET /novelties/1
   def show
      respond_to do |format|
         format.json { render json: @novelty.jsonize(context) }
      end
   end

   # POST /novelties
   def create
      @novelty.save!

      respond_to do |format|
         format.json { head :ok }
      end
   end

   # PATCH/PUT /novelties/1
   def update
      @novelty.update!(novelty_params)

      respond_to do |format|
         format.json { head :ok }
      end
   end

   # DELETE /novelties/1
   def destroy
      @novelty.destroy

      respond_to do |format|
         format.json { head :ok }
      end
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_novelty
         @novelty = model.find(params[:id])
      end

      def init_novelty
         @novelty = model.new(novelty_params)
      end

      def authorize_novelty
         authorize @novelty
      end

      def model
         Novelty
      end

      # Only allow a list of trusted parameters through.
      def novelty_params
         params.require(:novelty).permit(:text, :title, :author_id)
      end

      def context
         @context ||= { except: %i(created_at updated_at tsv) }
      end
end
