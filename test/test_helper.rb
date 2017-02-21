ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
    fixtures :all

    def datetime_to_hash(datetime, string)
        hash = {}
        hash[string +"(1i)"] = datetime.year
        hash[string +"(2i)"] = datetime.month
        hash[string +"(3i)"] = datetime.day
        hash[string +"(4i)"] = datetime.hour
        hash[string +"(5i)"] = datetime.min

        return hash
    end

    def buyCAD
        post purchases_path, params: {purchase: {from_currency: "USD", to_currency: "CAD", amount_spent: 1000}}
        cad_purchase = @user.purchases.order("created_at desc").first
        datetime = DateTime.parse("18th Feb 2017 04:05:00")
        cad_purchase.created_at = datetime
        cad_purchase.save
        return cad_purchase.exch_rate * 1000
    end

    def buyEUR
        post purchases_path, params: {purchase: {from_currency: "USD", to_currency: "EUR", amount_spent: 1000}}
        eur_purchase = @user.purchases.order("created_at desc").first
        datetime = DateTime.parse("18th Feb 2017 04:10:00")
        eur_purchase.created_at = datetime
        eur_purchase.save
        return eur_purchase.exch_rate * 1000
    end

    def buyAUD
        post purchases_path, params: {purchase: {from_currency: "USD", to_currency: "AUD", amount_spent: 1000}}
        aud_purchase = @user.purchases.order("created_at desc").first
        datetime = DateTime.parse("18th Feb 2017 04:15:00")
        aud_purchase.created_at = datetime
        aud_purchase.save
        return aud_purchase.exch_rate * 1000
    end

    def buyGBP
        post purchases_path, params: {purchase: {from_currency: "USD", to_currency: "GBP", amount_spent: 1000}}
        gbp_purchase = @user.purchases.order("created_at desc").first
        datetime = DateTime.parse("18th Feb 2017 04:20:00")
        gbp_purchase.created_at = datetime
        gbp_purchase.save
        return gbp_purchase.exch_rate * 1000
    end

    # attributes should be indexed by strings, and expected should be indexed by corresponding symbol
    def attribute_match(attributes, expected)
        attributes.each do |attribute, value|
            assert expected[attribute.intern] == value
        end
    end
end
