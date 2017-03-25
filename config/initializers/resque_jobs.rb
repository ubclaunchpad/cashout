# Start Redis server
# system 'redis-server /usr/local/etc/redis.conf'

# Declare all supported currencies
CURRENCIES = ['USD', 'CAD', 'EUR', 'JPY', 'GBP', 'CHF', 'AUD', 'ZAR', 'BTC']

# Clear any jobs left over in the queues from last session
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }

# Run the first job
GetExchangeRatesJob.perform
