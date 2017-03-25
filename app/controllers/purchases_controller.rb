class PurchasesController < ApplicationController
    before_action :set_purchase, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    include PurchasesHelper

    # GET /purchases
    # GET /purchases.json
    def index
        # We'll need to page this later!
        @purchases = current_user.purchases.all
    end

    # GET /purchases/new
    def new
        @purchase = Purchase.new(purchase_setup_params)
    end

    # POST /purchases
    # POST /purchases.json
    def create
        @purchase = Purchase.new(purchase_params)
        @portfolio = current_user.portfolio

        @purchase.user_id = current_user.id

        # Get exchange rate
        if @purchase.to_currency == 'BTC'
            if @purchase.from_currency != 'USD'
                flash.now[:alert] = 'Sorry, you can only buy BTC with USD.'
                render :new
                return
            end
            @purchase.exch_rate = 1.0/get_btc_value()
        elsif @purchase.from_currency == 'BTC'
            if @purchase.to_currency != 'USD'
                flash.now[:alert] = 'Sorry, you can only buy USD with BTC.'
                render :new
                return
            end
            @purchase.exch_rate = get_btc_value()
        else
            @purchase.exch_rate = $oer.exchange_rate(
                :from => @purchase.from_currency, :to => @purchase.to_currency)
        end

        if @purchase.amount_spent.nil? or @purchase.amount_spent <= 0
            flash.now[:alert] = 'Must supply purchase amount greater than 0'
            render :new
            return
        else
            @purchase.amount_bought = @purchase.exch_rate * @purchase.amount_spent
        end

        # Calculate portfolio entries
        from_curr_value = @portfolio.read_attribute(@purchase.from_currency)
        new_from_value = from_curr_value - @purchase.amount_spent

        to_curr_value = @portfolio.read_attribute(@purchase.to_currency)
        new_to_value = to_curr_value + @purchase.amount_bought

        # Update portfolio
        @portfolio.write_attribute(@purchase.from_currency, new_from_value)
        @portfolio.write_attribute(@purchase.to_currency, new_to_value)

        respond_to do |format|
            if @portfolio.save and @purchase.save
                if current_user.purchases.count % purchases_before_snapshot == 0
                    snapshot_data = @portfolio.attributes
                    snapshot_data.delete("id")
                    snapshot_data.delete("created_at")
                    snapshot_data.delete("updated_at")
                    snapshot_data.delete("user_id")

                    current_user.snapshots.create(snapshot_data)
                end

                flash[:notice] = 'Purchase was successfully created.'
                format.html { redirect_to purchases_path }
                format.json { render :index, status: :created, location: @purchase }
            else
                # Saving the portfolio or purchase failed
                if @purchase.errors.any?
                    # There were errors in the purchase, alert client
                    format.html { render :new }
                    format.json { render json: @purchase.errors, status: :unprocessable_entity }
                else
                    # There were errors in the portfolio, alert client
                    flash.now[:alert] = 'Insufficient Funds'
                    format.html { render :new }
                    format.json { render json: @portfolio.errors, status: :unprocessable_entity }
                end
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

    def purchase_setup_params
        params.permit(:from_currency, :to_currency)
    end
end
