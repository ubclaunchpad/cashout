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
end
