require 'test_helper'

class SummaryControllerTest < ActionDispatch::IntegrationTest

    def setup
        post user_registration_path params: {user: {username: "bingbong", \
            email: "bingbong@gmail.com", password: "bingbong", password_confirmation: "bingbong"}}
        @user = User.first
    end

# This test relies on having purchases_before_snapshot to be 2, otherwise, this test will fail.
# TODO: Make a test that doesn't require purchases_before_snapshot to be 2 (that is, autotmate
# creation purchases). Refine monetary arithmetic (use some standard or something). Note that for
# the snapshot functions to work, the 1st and 2nd snapshots (portfolio and first) cannot be created
# at the exact same time (in general, snapshot must be created at distinct times).
    test "snapshots should be correct" do
        assert @user.snapshots.count == 2
        @user.snapshots.find(1).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:00:00"))
        @user.snapshots.find(2).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:01:00"))

        cad = buyCAD
        eur = buyEUR
        assert @user.snapshots.count == 3
        @user.snapshots.find(3).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:10:00"))

        aud = buyAUD
        gbp = buyGBP
        assert @user.snapshots.count == 4
        @user.snapshots.find(4).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:20:00"))

        expected = {USD: 10000, CAD: 0, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        snapshot_correct("18th Feb 2017 04:02:00 UTC", expected)

        expected = {USD: 9000, CAD: cad, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        snapshot_correct("18th Feb 2017 04:07:00", expected)

        expected = {USD: 8000, CAD: cad, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        snapshot_correct("18th Feb 2017 04:12:00", expected)

        expected = {USD: 7000, CAD: cad, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: aud, ZAR: 0}
        snapshot_correct("18th Feb 2017 04:17:00", expected)

        expected = {USD: 6000, CAD: cad, EUR: eur, JPY: 0, GBP: gbp, CHF: 0, AUD: aud, ZAR: 0}
        snapshot_correct("18th Feb 2017 04:22:00", expected)
    end

    test "portfolio should update every purchase" do
        assert @user.snapshots.count == 2
        @user.snapshots.find(1).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:00:00"))
        @user.snapshots.find(2).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:01:00"))

        expected = {USD: 10000, CAD: 0, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        portfolio_correct(expected)

        cad = buyCAD
        expected = {USD: 9000, CAD: cad, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        portfolio_correct(expected)

        eur = buyEUR
        assert @user.snapshots.count == 3
        @user.snapshots.find(3).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:10:00"))
        expected = {USD: 8000, CAD: cad, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        portfolio_correct(expected)

        aud = buyAUD
        expected = {USD: 7000, CAD: cad, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: aud, ZAR: 0}
        portfolio_correct(expected)

        gbp = buyGBP
        assert @user.snapshots.count == 4
        @user.snapshots.find(4).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:20:00"))
        expected = {USD: 6000, CAD: cad, EUR: eur, JPY: 0, GBP: gbp, CHF: 0, AUD: aud, ZAR: 0}
        portfolio_correct(expected)
    end

# TODO: Check cases where first date is less that 4:00:00, and check backwards days.
    test "differences should be correct" do
        assert @user.snapshots.count == 2
        @user.snapshots.find(1).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:00:00"))
        @user.snapshots.find(2).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:01:00"))

        cad = buyCAD
        eur = buyEUR
        assert @user.snapshots.count == 3
        @user.snapshots.find(3).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:10:00"))

        aud = buyAUD
        gbp = buyGBP
        assert @user.snapshots.count == 4
        @user.snapshots.find(4).update_attribute("created_at", DateTime.parse("18th Feb 2017 04:20:00"))

        expected = {USD: -1000, CAD: 0, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        difference_correct("18th Feb 2017 04:07:00 UTC", "18th Feb 2017 04:012:00 UTC", expected)

        expected = {USD: -2000, CAD: 0, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: aud, ZAR: 0}
        difference_correct("18th Feb 2017 04:07:00 UTC", "18th Feb 2017 04:017:00 UTC", expected)

        expected = {USD: -3000, CAD: cad, EUR: eur, JPY: 0, GBP: 0, CHF: 0, AUD: aud, ZAR: 0}
        difference_correct("18th Feb 2017 04:02:00 UTC", "18th Feb 2017 04:017:00 UTC", expected)

        expected = {USD: 0, CAD: 0, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
        difference_correct("18th Feb 2017 04:17:00 UTC", "18th Feb 2017 04:17:00 UTC", expected)
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

    # Attributes should be indexed by strings, and expected should be indexed by corresponding symbol.
    # Also note that we match currencies if they are within 1.
    def attribute_match(attributes, expected)
        attributes.each do |attribute, value|
            assert (expected[attribute.intern] - value).abs <= 1
        end
    end

    def snapshot_correct(date, expected)
        snapshot_date = DateTime.parse(date)
        post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        snapshot_data = assigns[:snapshot_data]
        attribute_match(snapshot_data, expected)
    end

    def portfolio_correct(expected)
        get portfolio_path
        portfolio_data = assigns[:portfolio_data]
        attribute_match(portfolio_data, expected)
    end

    def difference_correct(date_s, date_e, expected)
        date_start = DateTime.parse(date_s)
        date_end = DateTime.parse(date_e)
        dates = datetime_to_hash(date_start, "date_start").merge(datetime_to_hash(date_end, "date_end"))
        post difference_path params: {dates: dates}
        difference_data = assigns[:difference_data]
        attribute_match(difference_data, expected)
    end


end
