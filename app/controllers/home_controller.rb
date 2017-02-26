class HomeController < ApplicationController
    def index
        # To store value of each supported currency in USD
        @current_rates = Hash.new

        CURRENCIES.each do |currency|
            new_entry = Hash.new

            # We cant do this, its too slow because of all the HTTP requests
            # todays_rate = $oer.exchange_rate(:from => "USD", :to => currency)
            # old_rate = $oer.exchange_rate(:from => "USD", :to => currency, :on => (Date.today - 1.month))
            # percent_change = (todays_rate - old_rate) / old_rate

            # new_entry[:value] = todays_rate
            # new_entry[:change] = percent_change
            # @current_rates[currency] = new_entry
        end

        render 'index'
    end
end
