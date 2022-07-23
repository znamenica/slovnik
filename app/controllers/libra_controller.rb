class LibraController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show]

   before_action :set_librum, only: [:show, :edit, :update, :destroy]

   # GET /libra
   def index
      @libra = Librum.all

      respond_to do |format|
         format.json do
            render plain: {
               list: @libra.as_json,
               page: @page,
               total: @libra.size
            }.to_json
         end
      end
   end

   # GET /libra/1
   def show
      respond_to do |format|
         format.json { render plain: @librum.as_json.to_json }
         #@librum.jsonize(context)
      end
   end

   # GET /libra/new
   def new
      @librum = Librum.new
   end

   # GET /libra/1/edit
   def edit
   end

   # POST /libra
   def create
      @librum = Librum.new(librum_params)

      @librum.save!
      respond_to do |format|
         format.json { render nothing: true, status: :ok }
         format.html { redirect_to @librum, notice: 'Librum was successfully created.' }
      end
   rescue
      respond_to do |format|
         format.json { render nothing: true, status: :locked }
         format.html { render :new }
      end
   end

   # PATCH/PUT /libra/1
   def update
      @librum.update!(librum_params)

      respond_to do |format|
         format.json { render nothing: true, status: :ok }
         format.html { redirect_to @librum, notice: 'Librum was successfully updated.' }
      end
   rescue
      respond_to do |format|
         format.json { render nothing: true, status: :locked }
         format.html { render :edit }
      end
   end

   # DELETE /libra/1
   def destroy
      @librum.destroy

      respond_to do |format|
         format.json { render nothing: true, status: :ok }
         format.html { redirect_to libra_url, notice: 'Librum was successfully destroyed.' }
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_librum
      @librum = Librum.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def librum_params
      params.require(:librum).permit(:text, :title, :author_id)
   end
end
