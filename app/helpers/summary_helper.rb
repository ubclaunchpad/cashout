module SummaryHelper

    def datetime_to_hash(datetime, string)
        hash = {}
        hash[string +"(1i)"] = datetime.year
    end
end
