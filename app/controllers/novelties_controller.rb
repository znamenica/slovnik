class NoveltiesController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show]

   before_action :set_novelty, only: [:show, :edit, :update, :destroy]

   # GET /novelties
   def index
      @novelties = Novelty.all.page(params[:p])

      respond_to do |format|
         format.json do
            render plain: {
               list: @novelties.jsonize(context),
               page: @page,
               total: @novelties.total_count
            }.to_json
         end
      end
   end

   # GET /novelties/1
   def show
      respond_to do |format|
         format.json { render :show, json: @novelty.jsonize(context) }
      end
   end

   # GET /novelties/new
   def new
      @novelty = Novelty.new
   end

   # GET /novelties/1/edit
   def edit
   end

   # POST /novelties
   def create
      @novelty = Novelty.new(novelty_params)

      @novelty.save!
      respond_to do |format|
         format.json { head :ok }
         format.html { redirect_to @novelty, notice: 'Novelty was successfully created.' }
      end
   rescue
      respond_to do |format|
         format.json { head :locked }
         format.html { render :new }
      end
   end

   # PATCH/PUT /novelties/1
   def update
      @novelty.update!(novelty_params)

      respond_to do |format|
         format.json { head :ok }
         format.html { redirect_to @novelty, notice: 'Novelty was successfully updated.' }
      end
   rescue
      respond_to do |format|
         format.json { head :locked }
         format.html { render :edit }
      end
   end

   # DELETE /novelties/1
   def destroy
      @novelty.destroy

      respond_to do |format|
         format.json { head :ok }
         format.html { redirect_to novelties_url, notice: 'Novelty was successfully destroyed.' }
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_novelty
      @novelty = Novelty.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def novelty_params
      params.require(:novelty).permit(:text, :title, :author_id)
   end

   def context
      @context ||= { except: %i(created_at updated_at tsv) }
   end
end
