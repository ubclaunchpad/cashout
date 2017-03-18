class HomeController < ApplicationController
    def index
        # Get today's exchange rates
        todays_rates = ExchangeRatesRecord.order('created_at').last
        last_weeks_rates = ExchangeRatesRecord.where("created_at <= ?", Date.today - 7 ).limit(1).first

        @rates = Hash.new
        todays_rates.attributes.each do |currency, value_today|
            if currency.in? CURRENCIES
                if last_weeks_rates.nil?
                    # Don't have records of exchange rates that far in the past
                    # Get them from OER
                    value_last_week = $oer.exchange_rate(:from => "USD",
                        :to => currency, :on => (Date.today - 7).to_s)
                else
                    # We have a record from a week ago in the db
                    # So we use that
                    value_last_week = last_weeks_rates.read_attribute(currency)
                end

                # Compute percent change
                delta = (value_today - value_last_week)/value_last_week*100
                @rates[currency] = { value: value_today, delta: delta }
            end
        end

        render 'index'
    end
end
