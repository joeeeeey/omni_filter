# -*- coding: UTF-8 -*-

require 'json'
require_relative './utils/output'
require_relative './filters/color_filter'
require_relative './filters/all_keys_filter'
require_relative './filters/url_filter'

# begin
  # Notice: 英文 ',' 来分隔参数
  # ARGV   
  params = ARGV[0]

  category, *args = params.split(',')

  if args
    if args && args.size != 0
      key, params = args
    end
  end

  case category
  when 'color' then ColorFilter.do_filter(key)
  when 'allkeys' then AllKeysFilter.do_filter(key)
  when 'stt' then UrlFilter.do_filter(key, params)  
  else
    item = {
      :title => 'Whoop! An unknow keyword.', 
    }
    Output.put(item)
  end
	
# rescue Exception => e
#   item = {
#     :title => 'SOME ERROR HAPPENED.', 
#     :subtitle => "#{e.to_s}",
#   }
#   Output.put(item)
# end