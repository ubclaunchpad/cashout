require 'test_helper'

class SummaryControllerTest < ActionDispatch::IntegrationTest

    def setup
        post user_registration_path params: {user: {username: "bingbong", \
            email: "bingbong@gmail.com", password: "bingbong", password_confirmation: "bingbong"}}
        @user = User.first
    end

# this test relies on having purchases_before_snapshot to be 2, otherwise, this test might pass accidently
    test "shapshots should be correct" do
        cad = buyCAD
        eur = buyEUR
        aud = buyAUD
        gbp = buyGBP

        snapshot_data = {}

        # snapshot_date = DateTime.parse("18th Feb 2017 04:02:00")
        # post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        # snapshot_data = assigns[:snapshot_data]
        # assert snapshot_data["USD"] == 10000
        # assert snapshot_data["CAD"] == 0
        # assert snapshot_data["EUR"] == 0
        # assert snapshot_data["JPY"] == 0
        # assert snapshot_data["GBP"] == 0
        # assert snapshot_data["CHF"] == 0
        # assert snapshot_data["AUD"] == 0
        # assert snapshot_data["ZAR"] == 0

        # snapshot_date = DateTime.parse("18th Feb 2017 04:07:00")
        # post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        # snapshot_data = assigns[:snapshot_data]
        # assert snapshot_data["USD"] == 9000
        # assert snapshot_data["CAD"] == cad
        # assert snapshot_data["EUR"] == 0
        # assert snapshot_data["JPY"] == 0
        # assert snapshot_data["GBP"] == 0
        # assert snapshot_data["CHF"] == 0
        # assert snapshot_data["AUD"] == 0
        # assert snapshot_data["ZAR"] == 0
        #
        # snapshot_date = DateTime.parse("18th Feb 2017 04:12:00")
        # post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        # snapshot_data = assigns[:snapshot_data]
        # assert snapshot_data["USD"] == 8000
        # assert snapshot_data["CAD"] == cad
        # assert snapshot_data["EUR"] == eur
        # assert snapshot_data["JPY"] == 0
        # assert snapshot_data["GBP"] == 0
        # assert snapshot_data["CHF"] == 0
        # assert snapshot_data["AUD"] == 0
        # assert snapshot_data["ZAR"] == 0
        #
        # snapshot_date = DateTime.parse("18th Feb 2017 04:17:00")
        # post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        # snapshot_data = assigns[:snapshot_data]
        # assert snapshot_data["USD"] == 7000
        # assert snapshot_data["CAD"] == cad
        # assert snapshot_data["EUR"] == eur
        # assert snapshot_data["JPY"] == 0
        # assert snapshot_data["GBP"] == 0
        # assert snapshot_data["CHF"] == 0
        # assert snapshot_data["AUD"] == aud
        # assert snapshot_data["ZAR"] == 0

        snapshot_date = DateTime.parse("18th Feb 2017 04:22:00")
        post snapshot_path params: {date: datetime_to_hash(snapshot_date, "date")}
        snapshot_data = assigns[:snapshot_data]
        puts snapshot_data
        puts cad
        assert snapshot_data["USD"] == 6000
        assert snapshot_data["CAD"] == cad
        assert snapshot_data["EUR"] == eur
        assert snapshot_data["JPY"] == 0
        assert snapshot_data["GBP"] == gbp
        assert snapshot_data["CHF"] == 0
        assert snapshot_data["AUD"] == aud
        assert snapshot_data["ZAR"] == 0
    end

    # test "portfolio should update every purchase" do
    #     get portfolio_path
    #     portfolio_data = assigns[:portfolio_data]
    #     # expected = {USD: 1000, CAD: 220, EUR: 0, JPY: 0, GBP: 0, CHF: 0, AUD: 0, ZAR: 0}
    #     # attribute_match(portfolio_data, expected)
    #
    #     assert portfolio_data["USD"] == 10000
    #     assert portfolio_data["CAD"] == 0
    #     assert portfolio_data["EUR"] == 0
    #     assert portfolio_data["JPY"] == 0
    #     assert portfolio_data["GBP"] == 0
    #     assert portfolio_data["CHF"] == 0
    #     assert portfolio_data["AUD"] == 0
    #     assert portfolio_data["ZAR"] == 0
    #
    #     cad = buyCAD
    #
    #     get portfolio_path
    #     portfolio_data = assigns[:portfolio_data]
    #     assert portfolio_data["USD"] == 9000
    #     assert portfolio_data["CAD"] == cad
    #     assert portfolio_data["EUR"] == 0
    #     assert portfolio_data["JPY"] == 0
    #     assert portfolio_data["GBP"] == 0
    #     assert portfolio_data["CHF"] == 0
    #     assert portfolio_data["AUD"] == 0
    #     assert portfolio_data["ZAR"] == 0
    #
    #     eur = buyEUR
    #
    #     get portfolio_path
    #     portfolio_data = assigns[:portfolio_data]
    #     assert portfolio_data["USD"] == 8000
    #     assert portfolio_data["CAD"] == cad
    #     assert portfolio_data["EUR"] == eur
    #     assert portfolio_data["JPY"] == 0
    #     assert portfolio_data["GBP"] == 0
    #     assert portfolio_data["CHF"] == 0
    #     assert portfolio_data["AUD"] == 0
    #     assert portfolio_data["ZAR"] == 0
    #
    #     aud = buyAUD
    #
    #     get portfolio_path
    #     portfolio_data = assigns[:portfolio_data]
    #     assert portfolio_data["USD"] == 7000
    #     assert portfolio_data["CAD"] == cad
    #     assert portfolio_data["EUR"] == eur
    #     assert portfolio_data["JPY"] == 0
    #     assert portfolio_data["GBP"] == 0
    #     assert portfolio_data["CHF"] == 0
    #     assert portfolio_data["AUD"] == aud
    #     assert portfolio_data["ZAR"] == 0
    #
    #     gbp = buyGBP
    #
    #     get portfolio_path
    #     portfolio_data = assigns[:portfolio_data]
    #     assert portfolio_data["USD"] == 6000
    #     assert portfolio_data["CAD"] == cad
    #     assert portfolio_data["EUR"] == eur
    #     assert portfolio_data["JPY"] == 0
    #     assert portfolio_data["GBP"] == gbp
    #     assert portfolio_data["CHF"] == 0
    #     assert portfolio_data["AUD"] == aud
    #     assert portfolio_data["ZAR"] == 0
    # end

    # test "differences should be correct" do
    #
    # end

end
