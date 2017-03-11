class SummaryController < ApplicationController
    before_action :authenticate_user!

    def show_portfolio
        portfolio = current_user.portfolio
        @portfolio_data = portfolio.attributes
        @portfolio_data.delete("id")
        @portfolio_data.delete("created_at")
        @portfolio_data.delete("updated_at")
        @portfolio_data.delete("user_id")
    end

    def get_date
    end

    def show_snapshot
        hash = params["date"]
        datetime = get_datetime_from_hash(hash, "date")
        @snapshot_data = get_snapshot_data_at_datetime(datetime)
    end

    def get_dates
    end

    # handle the case where the first date is greater than the second date
    def show_difference
        hash = params["dates"]
        datetime_start = get_datetime_from_hash(hash, "date_start")
        datetime_end = get_datetime_from_hash(hash, "date_end")

        snapshot_data_start = get_snapshot_data_at_datetime(datetime_start)
        snapshot_data_end = get_snapshot_data_at_datetime(datetime_end)

        @difference_data = snapshot_data_end
        snapshot_data_start.each do |currency, value|
            @difference_data[currency] -= value
        end
    end

    private

        # If the form involves more than one datetime, all dates times will be in the
        # "hash". The "date" string specifies which datetime to turn to a string.
        def get_datetime_from_hash(hash, date)
            string = hash[date +"(1i)"] + "-" + hash[date +"(2i)"] + "-" + hash[date +"(3i)"] + \
                "TO" + hash[date +"(4i)"] + ":" + hash[date +"(5i)"] + ":" + "00"
            return DateTime.parse(string)
        end

        def get_snapshot_data_at_datetime(datetime)
            user_id = current_user.read_attribute("id")

            # Change this for efficiency
            snapshot = Snapshot.where("user_id == ? AND created_at <= ?", user_id, datetime).order( \
                "created_at desc").first

            if snapshot == nil
                snapshot = Snapshot.find(1)
            end

            snapshot_data = snapshot.attributes
            snapshot_data.delete("id")
            snapshot_data.delete("created_at")
            snapshot_data.delete("updated_at")
            snapshot_data.delete("user_id")

            snapdate = snapshot.read_attribute("created_at")
            purchases = current_user.purchases.where("created_at > ? AND created_at <= ?", snapdate, datetime)

            purchases.each do |purchase|
                snapshot_data[purchase.from_currency] -= purchase.amount_spent
                snapshot_data[purchase.to_currency] += purchase.amount_bought
            end

            return snapshot_data
        end
end
