include ApplicationHelper
require_relative '../models/purchase'

class GetExchangeRatesJob < ApplicationJob
    @queue = :get_exchange_rates

    # This method is called every time the job runs
    def self.perform
        # Enqueue this same job for tomorrow at midnight
        GetExchangeRatesJob.set(wait_until: Date.tomorrow.midnight).perform_later

        dont_execute = (
            ARGV.include?("db:migrate") or
            (
                (not ExchangeRatesRecord.first.nil?) &&
                (ExchangeRatesRecord.first.read_attribute(:created_at).to_date == Date.today.to_date)
            )
        )

        # Get most recent exchange rates and store them in the database
        unless dont_execute
            exchange_rates_record = ExchangeRatesRecord.new
            $oer.latest.rates.each do |currency, value|
                if CURRENCIES.include? currency
                    exchange_rates_record.write_attribute(currency, value.to_d)
                end
            end
            exchange_rates_record.write_attribute('BTC', get_btc_value().to_d)
            exchange_rates_record.save!
            puts 'Ran job!'
        end
    end
end
