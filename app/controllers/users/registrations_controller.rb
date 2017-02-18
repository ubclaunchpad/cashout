class Users::RegistrationsController < Devise::RegistrationsController
    def new
        super
    end

    def create
        super

        # Create user portfolio
        if resource.save
            @portfolio = Portfolio.new
            @portfolio.user = resource
            resource.portfolio = @portfolio
            @portfolio.save
        end
    end

    def edit
        super
    end

    def destroy
        super
    end
end
