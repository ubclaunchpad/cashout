class Users::RegistrationsController < Devise::RegistrationsController
    def new
        super
    end

    def create
        super

        if not current_user.nil?
            #Create the "updated snapshot" entry, which is a temporary relacement for the portfolio
            current_user.snapshots.create(USD: 10000, CAD: 0, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0)

            #Create the first entry
            current_user.snapshots.create(USD: 10000, CAD: 0, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0)
        end
    end

    def edit
        super
    end

    def destroy
        super
    end
end
