# Cashout
## A fantasy currency trading app

Uses [Open Exchange Rates API](https://github.com/vlado/open_exchange_rates)

### Important!

Before you run migrations make sure you comment out the last few lines in
`get_exchange_rates.rb`. Rails insists on running that job before running the
migrations which causes errors.

- Comment out the code at the bottom of in `get_exchange_rates.rb`
- Run migrations
- Uncomment the code
- Run the server

### Core Features:
- Talks to open APIs like FOREX to track currency values
- Each user gets and account with seed money (maybe $10000) and can buy and sell
- Users can buy and sell currencies
- User performance ranking (compared to other users)
- Allow users to reset their balance periodically (maybe every week) if they go bankrupt  

### Secondary features:
- Allow users to set up leagues among friends
- Open API to allow people to write their own bots or algorithms that can use the app through their profile (or make this feature like an Integration the way Slack does)
- Show how many times the user has reset on his/her profile (mark of shame)
- Allow users to comment on why they made certain trade decisions
- News feed with world events that could effect currency value (might be a problem if this influences users choice)

### Supported Currencies
- USD
- CAD
- EUR
- JPY
- GBP
- CHF
- AUD
- ZAR
