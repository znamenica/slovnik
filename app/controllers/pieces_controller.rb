# frozen_string_literal: true

class PiecesController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_piece, only: %i(show update destroy)

   respond_to :json

   # GET /pieces
   def index
      @pieces = Piece.all.page(@page)

      render json: {
         list: @pieces.jsonize(context),
         page: @page,
         total: @pieces.total_count
      }
   end

   # GET /pieces/1
   def show
      render json: @piece.jsonize(context)
   end

   # POST /pieces
   def create
      @piece = Piece.create(piece_params)

      head :ok
   end

   # PATCH/PUT /pieces/1
   def update
      @piece.update!(piece_params)

      head :ok
   end

   # DELETE /pieces/1
   def destroy
      @piece.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_piece
         @piece = Piece.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def piece_params
         params.require(:piece).permit(:id, :text, meta: {}, language_ids: [])
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
