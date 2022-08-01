class GrammarsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_grammar, only: %i(show update destroy)

   respond_to :json

   # GET /grammars
   def index
      @grammars = Grammar.all.page(@page)

      render json: {
         list: @grammars.jsonize(context),
         page: @page,
         total: @grammars.total_count
      }
   end

   # GET /grammars/1
   def show
      render json: @grammar.jsonize(context)
   end

   # POST /grammars
   def create
      @grammar = Grammar.create(grammar_params)

      head :ok
   end

   # PATCH/PUT /grammars/1
   def update
      @grammar.update!(grammar_params)

      head :ok
   end

   # DELETE /grammars/1
   def destroy
      @grammar.destroy

      head :ok
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_grammar
      @grammar = Grammar.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def grammar_params
      params.require(:grammar).permit(:id, :language_id, :alphabeth_id, :dictionary_id, meta: {})
   end

   def context
      @context ||= { except: %i(created_at updated_at) }
   end
end
