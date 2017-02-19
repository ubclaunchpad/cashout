class PurchasesController < ApplicationController
    before_action :set_purchase, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    # GET /purchases
    # GET /purchases.json
    def index
        # We'll need to page this later!
        @purchases = current_user.purchases.all
    end

    # GET /purchases/new
    def new
        @purchase = Purchase.new
    end

    # POST /purchases
    # POST /purchases.json
    def create
        @purchase = Purchase.new(purchase_params)
        @portfolio = Portfolio.where(:id => current_user.id).first

        @purchase.user_id = current_user.id
        @purchase.exch_rate = $oer.exchange_rate(:from => @purchase.from_currency, :to => @purchase.to_currency)
        puts 'Exchange rate: ' + @purchase.exch_rate.to_s #TODO remove
        puts 'Amount spent: ' + @purchase.amount_spent.to_s + ' ' + @purchase.from_currency.to_s #TODO remove

        if @purchase.amount_spent.nil? or @purchase.amount_spent <= 0
            flash.now[:alert] = 'Must supply purchase amount greater than 0'
            render :new
            return
        else
            @purchase.amount_bought = @purchase.exch_rate * @purchase.amount_spent
            puts 'Amount bought: ' + @purchase.amount_bought.to_s + ' ' + @purchase.to_currency.to_s #TODO remove
        end

        # Calculate portfolio entries
        from_curr_value = @portfolio.read_attribute(@purchase.from_currency)
        puts 'Old from value: ' + from_curr_value.to_s # TODO remove
        new_from_value = from_curr_value - @purchase.amount_spent
        puts 'New from value: ' + new_from_value.to_s # TODO remove

        to_curr_value = @portfolio.read_attribute(@purchase.to_currency)
        puts 'Old to value: ' + to_curr_value.to_s # TODO remove
        new_to_value = to_curr_value + @purchase.amount_bought
        puts 'New to value: ' + new_to_value.to_s # TODO remove

        # Update portfolio
        @portfolio.write_attribute(@purchase.from_currency, new_from_value)
        @portfolio.write_attribute(@purchase.to_currency, new_to_value)

        respond_to do |format|
            if not @portfolio.save
                flash.now[:alert] = 'Insufficient Funds'
                format.html { render :new }
                format.json { render json: @portfolio.errors, status: :unprocessable_entity }
            elsif @purchase.save
                flash[:notice] = 'Purchase was successfully created.'
                format.html { redirect_to purchases_path }
                format.json { render :index, status: :created, location: @purchase }
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
