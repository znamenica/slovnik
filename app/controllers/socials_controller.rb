# frozen_string_literal: true

class SocialsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_social, only: %i(show update destroy)

   respond_to :json

   # GET /socials
   def index
      @socials = Social.all.page(@page)

      render json: {
         list: @socials.jsonize(context),
         page: @page,
         total: @socials.total_count
      }
   end

   # GET /socials/1
   def show
      render json: @social.jsonize(context)
   end

   # POST /socials
   def create
      @social = Social.create(social_params)

      head :ok
   end

   # PATCH/PUT /socials/1
   def update
      @social.update!(social_params)

      head :ok
   end

   # DELETE /socials/1
   def destroy
      @social.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_social
         @social = Social.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def social_params
         params.require(:social).permit(:id, :uri, :kind, meta: {})
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
