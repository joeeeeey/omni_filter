require_relative './filters/color_filter'
require 'gyoku'
require 'json'

begin
	ColorFilter.do_filter
rescue Exception => e
  hash = {
    xml: {
      items: {
        item: {}
      }
    }
  }

  item = {
    :title => 'SOME ERROR HAPPENED', # 
    :subtitle => "#{e.to_s}",
  }

  hash[:xml][:items][:item] = item

  xml = Gyoku.xml(hash)

  puts xml 
end

