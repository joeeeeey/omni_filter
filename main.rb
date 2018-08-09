# -*- coding: UTF-8 -*-
# require 'bundler/setup'
require 'json'
require 'active_support/all'
require_relative './utils/output'
require_relative './filters/color_filter'
require_relative './filters/all_keys_filter'
require_relative './filters/url_filter'
require_relative './extension/hash'

# begin
  # Notice: 英文 ',' 来分隔参数
  # ARGV   
  params = ARGV[0]
  polishedParams = params.gsub('，', ',')

  category, *args = polishedParams.split(',')

  if args
    if args && args.size != 0
      key, argParams = args
    end
  end

  case category
  when 'color' then ColorFilter.do_filter(key)
  when 'allkeys' then AllKeysFilter.do_filter(key)
  when 'stt' then UrlFilter.do_filter(key, argParams)  
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