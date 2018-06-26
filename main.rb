# require 'gyoku'
require 'json'

require_relative './utils/output'
require_relative './filters/color_filter'
require_relative './filters/all_keys_filter'


begin
  # Notice: 在 alfred 输入框中, 每个空格都会增加 ARGV 参数个数
  # ARGV   
  params = ARGV[0]
  category = params.split('-')[0]
  key = params.split('-')[1]

  case category
  when 'color' then ColorFilter.do_filter(key)
  when 'allkeys' then AllKeysFilter.do_filter(key)  
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

# whole_hash = {}
# Dir["./assets/*.json"].each do |file| 
#   colorMappingJsonString = File.read file
#   colorMapping = JSON.parse(colorMappingJsonString)
#   colorMapping.each do |k, v|
#     if v.is_a? String
#       whole_hash[k] = v
#     end
#   end
# end

# p whole_hash
