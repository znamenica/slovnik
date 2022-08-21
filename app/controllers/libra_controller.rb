# frozen_string_literal: true

class LibraController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show]

   before_action :set_librum, only: %i(show update destroy)
   before_action :init_librum, only: :create
   before_action :authorize_librum, only: %i(create update destroy)

   has_scope :by_tags, only: %i(index), type: :array

   # GET /libra
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

   # GET /libra/1
   def show
      respond_to do |format|
         format.json { render json: @librum.jsonize(context) }
      end
   end

   # POST /libra
   def create
      @librum.save!

      respond_to do |format|
         format.json { head :ok }
      end
   end

   # PATCH/PUT /libra/1
   def update
      @librum.update!(librum_params)

      respond_to do |format|
         format.json { head :ok }
      end
   end

   # DELETE /libra/1
   def destroy
      @librum.destroy

      respond_to do |format|
         format.json { head :ok }
      end
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_librum
         @librum = Librum.find(params[:id])
      end

      def init_librum
         @librum = model.new(librum_params)
      end

      def authorize_librum
         authorize @librum
      end

      def model
         Librum
      end

      # Only allow a list of trusted parameters through.
      def librum_params
         params.require(:librum).permit(:text, :title, :author_id, :abstract, :cover_uri, tags: [])
      end

      def context
         @context ||= { except: %i(created_at updated_at tsv) }
      end
end
