class Users::RegistrationsController < Devise::RegistrationsController
    def new
        super
    end

    def create
        super

        # Create user portfolio
        @portfolio = Portfolio.new
        current_user.portfolio = @portfolio
        
    end

    def edit
        super
    end

    def destroy
        super
    end
end
