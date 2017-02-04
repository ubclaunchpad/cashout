class PurchasesController < ApplicationController
    before_action :set_purchase, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    # GET /purchases
    # GET /purchases.json
    def index
        @purchases = current_user.purchases.all
    end

    # GET /purchases/1
    # GET /purchases/1.json
    def show
    end

    # GET /purchases/new
    def new
        @purchase = Purchase.new
    end

    # POST /purchases
    # POST /purchases.json
    def create
        @purchase = Purchase.new(purchase_params)
        @purchase.user_id = current_user.id
        @purchase.exch_rate = $oer.exchange_rate(:from => 'USD', :to => @purchase.to_currency)

        if not @purchase.amount_spent.nil? 
            @purchase.amount_bought = @purchase.exch_rate * @purchase.amount_spent
        end

        respond_to do |format|
            if @purchase.save
                format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
                format.json { render :show, status: :created, location: @purchase }
            else
                format.html { render :new }
                format.json { render json: @purchase.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
        @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
        params.require(:purchase).permit(:from_currency, :to_currency, :amount_spent)
    end
end
