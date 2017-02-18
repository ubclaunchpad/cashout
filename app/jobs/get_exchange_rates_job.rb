class GetExchangeRatesJob < ApplicationJob
    queue_as :default

    # This method is called every time the job runs
    def perform
        # Enqueue this same job for tomorrow at midnight
        GetExchangeRatesJob.set(wait_until: Date.tomorrow.midnight).perform_later

        # Get most recent exchange rates and store them in the database
        exchange_rates_record = ExchangeRatesRecord.new
        $oer.latest.rates.each do |currency, value|
            if Purchase::CURRECIES.include? currency
                exchange_rates_record.attributes[currency] = value
            end
        end
    end
end
