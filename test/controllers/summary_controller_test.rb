require 'test_helper'

class SummaryControllerTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:bingbong)
    end

    test "shapshots should be correct" do
        get new_user_session
        post user_session(@user)

        get new_purchase_path
        post purchases_path params: {from_currency: "USD", to_currency: "CAD", amount_spent: 1000}
        cad_purchase = @user.purchases.order("created_at desc").first
        cad = cad_purchase.exch_rate * 1000
        datetime = DateTime.parse("18th Feb 2017 04:05:00")
        cad_purchase.created_at = datetime
        cad_purchase.save

        get new_purchase_path
        post purchases_path params: {from_currency: "USD", to_currency: "EUR", amount_spent: 1000}
        eur_purchase = @user.purchases.order("created_at desc").first
        eur = eur_purchase.exch_rate * 1000
        datetime = DateTime.parse("18th Feb 2017 04:10:00")
        eur_purchase.created_at = datetime
        eur_purchase.save

        get new_purchase_path
        post purchases_path params: {from_currency: "USD", to_currency: "AUD", amount_spent: 1000}
        aud_purchase = @user.purchases.order("created_at desc").first
        aud = aud_purchase.exch_rate * 1000
        datetime = DateTime.parse("18th Feb 2017 04:15:00")
        aud_purchase.created_at = datetime
        aud_purchase.save

        get new_purchase_path
        post purchases_path params: {from_currency: "USD", to_currency: "GBP", amount_spent: 1000}
        gbp_purchase = @user.purchases.order("created_at desc").first
        gbp = gbp_purchase.exch_rate * 1000
        datetime = DateTime.parse("18th Feb 2017 04:20:00")
        gbp_purchase.created_at = datetime
        gbp_purchase.save


        get 

    end
end
