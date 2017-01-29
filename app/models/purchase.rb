class Purchase < ApplicationRecord
    belongs_to :user

    enum currency: [:USD, :CAD, :EUR, :JPY, :GBP, :CHF, :AUD, :ZAR]

    validates :from_currency, inclusion: {in: currencies}
    validates :to_currency, inclusion: {in: currencies}
    validate :currencies_different_validation
    validates :user, presence: true
    validates :amount_spent, presence: true
    validates :amount_bought, presence: true
    validates :exch_rate, presence: true, numericality: { greater_than: 0 }

    def currencies_different_validation
        if self.from_currency == self.to_currency
            errors.add_to_base("Currencies must be different")
        end
    end
end
