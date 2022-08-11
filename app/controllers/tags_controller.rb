# frozen_string_literal: true

class TagsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_tag, only: %i(show update destroy)

   respond_to :json

   # GET /tags
   def index
      @tags = Tag.all.page(@page)

      render json: {
         list: @tags.jsonize(context),
         page: @page,
         total: @tags.total_count
      }
   end

   # GET /tags/1
   def show
      render json: @tag.jsonize(context)
   end

   # POST /tags
   def create
      @tag = Tag.create(tag_params)

      head :ok
   end

   # PATCH/PUT /tags/1
   def update
      @tag.update!(tag_params)

      head :ok
   end

   # DELETE /tags/1
   def destroy
      @tag.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag
         @tag = Tag.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tag_params
         params.require(:tag).permit(:id, :kind)
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
