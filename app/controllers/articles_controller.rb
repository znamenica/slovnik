# frozen_string_literal: true

class ArticlesController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_article, only: %i(show update destroy)

   respond_to :json

   # GET /articles
   def index
      @articles = Article.all.page(@page)

      render json: {
         list: @articles.jsonize(context),
         page: @page,
         total: @articles.total_count
      }
   end

   # GET /articles/1
   def show
      render json: @article.jsonize(context)
   end

   # POST /articles
   def create
      @article = Article.create(article_params)

      head :ok
   end

   # PATCH/PUT /articles/1
   def update
      @article.update!(article_params)

      head :ok
   end

   # DELETE /articles/1
   def destroy
      @article.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
         @article = Article.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def article_params
         params.require(:article).permit(:id, :kind, :meaning_id, :grammar_id, token_ids: [], tag_ids: [], separators: [],
            meta: {})
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
