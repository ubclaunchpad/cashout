class Purchase < ApplicationRecord
    belongs_to :user

    validates :from_currency, inclusion: CURRENCIES
    validates :to_currency, inclusion: CURRENCIES
    validate :currencies_different_validation
    validates :user, presence: true
    validates :amount_spent, presence: true, allow_nil: false
    validates :amount_bought, presence: true, allow_nil: false
    validates :exch_rate, presence: true, numericality: { greater_than: 0 }

    def currencies_different_validation
        if self.from_currency == self.to_currency
            errors.add(:from_currency, "Currencies must be different")
            errors.add(:to_currency, "Currencies must be different")
        end
    end
end
