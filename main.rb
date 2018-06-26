require 'gyoku'
require 'json'
require_relative './filters/color_filter'
require_relative './utils/output'

begin
  params = ARGV[0]
  category = params.split('-')[0]
  key = params.split('-')[1]

  case category
  when 'color'
    ColorFilter.do_filter(key)
  else
    item = {
      :title => 'Whoop! An unknow keyword', 
    }
    Output.put(item)
  end
	
rescue Exception => e
  item = {
    :title => 'SOME ERROR HAPPENED', 
    :subtitle => "#{e.to_s}",
  }
  Output.put(item)
end