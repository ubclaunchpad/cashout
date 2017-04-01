module ApplicationHelper
    require 'net/http'

    def get_btc_value()
        url = URI.parse('http://api.coindesk.com/v1/bpi/currentprice.json')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        return JSON.parse(res.body)['bpi']['USD']['rate'].remove(',').to_d
    end

    def get_btc_value_last_week()
        today = Date.today.to_s
        last_week = (Date.today - 7).to_s
        url = URI.parse('http://api.coindesk.com/v1/bpi/historical/close.json' +
            '?start=' + last_week + '&end=' + today)
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        return JSON.parse(res.body)['bpi'][last_week.to_s].to_d
    end
end
