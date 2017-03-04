class Portfolio < ApplicationRecord
    belongs_to :user

    validates_each :USD, :CAD, :EUR, :JPY, :GBP, :CHF, :AUD, :ZAR do |record, attribute, value|
        record.errors.add(attribute, 'Insufficient funds for purchase') if value < 0
    end

end
