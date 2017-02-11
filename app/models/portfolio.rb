class Portfolio < ApplicationRecord
    belongs_to :user

    validate :all_values_geq_zero

    def all_values_geq_zero
        self.attributes.each do |key, value|
            if value < 0
                errors.add(key, 'Insufficient Funds')
            end
        end
    end
end
