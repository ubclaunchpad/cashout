require_relative '../models/purchase'

class GetExchangeRatesJob < ApplicationJob
    @queue = :get_exchange_rates

    # This method is called every time the job runs
    def self.perform
        # Enqueue this same job for tomorrow at midnight
        GetExchangeRatesJob.set(wait_until: Date.tomorrow.midnight).perform_later

        # Get most recent exchange rates and store them in the database
        exchange_rates_record = ExchangeRatesRecord.new
        $oer.latest.rates.each do |currency, value|
            if CURRENCIES.include? currency
                exchange_rates_record.write_attribute(currency, value.to_d)
            end
        end
        exchange_rates_record.save
        puts 'Ran job!'
    end
end
