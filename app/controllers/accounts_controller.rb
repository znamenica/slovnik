# frozen_string_literal: true

class AccountsController < ApplicationController
   skip_before_action :authenticate_user!, only: %i(index show)

   before_action :set_account, only: %i(show update destroy)

   respond_to :json

   # GET /accounts
   def index
      @accounts = Account.all.page(@page)

      render json: {
         list: @accounts.jsonize(context),
         page: @page,
         total: @accounts.total_count
      }
   end

   # GET /accounts/1
   def show
      render json: @account.jsonize(context)
   end

   # POST /accounts
   def create
      @account = Account.create(account_params)

      head :ok
   end

   # PATCH/PUT /accounts/1
   def update
      @account.update!(account_params)

      head :ok
   end

   # DELETE /accounts/1
   def destroy
      @account.destroy

      head :ok
   end

   private
      # Use callbacks to share common setup or constraints between actions.
      def set_account
         @account = Account.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def account_params
         params.require(:account).permit(:id, :user_id, :social_id, :sid)
      end

      def context
         @context ||= { except: %i(created_at updated_at) }
      end
end
