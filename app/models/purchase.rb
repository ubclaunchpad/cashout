class Purchase < ApplicationRecord
    enum currency: [:USD, :CAD, :EUR, :JPY, :GBP, :CHF, :AUD, :ZAR]

    validates :from_currency, :inclusion => {in: currency}
    validates :to_currency, :inclusion => {in: currency}
    validates :user, presence: true
    validates :amount_spent, presence: true
    validates :amount_bought, presence: true
    validates :exch_rate, presence: true
    
    belongs_to :user
end
