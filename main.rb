# -*- coding: UTF-8 -*-

require 'json'
require_relative './activesupport-5.0.0/lib/active_support/core_ext/hash/conversions'
require_relative './utils/output'
require_relative './filters/color_filter'
require_relative './filters/all_keys_filter'
require_relative './filters/url_filter'

# xml = <<-XML
# <?xml version="1.0"?><items><item uid="tylereich.colors css-named to css-named" valid="yes" autocomplete="cadetblue" arg="cadetblue"><title>cadetblue</title><subtitle>CSS • Named Color</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to css-rgb" valid="yes" arg="rgb(95, 158, 160)"><title>rgb(95, 158, 160)</title><subtitle>CSS • RGB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to css-rgb%" valid="yes" arg="rgb(37%, 62%, 63%)"><title>rgb(37%, 62%, 63%)</title><subtitle>CSS • RGB Percent</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to css-hex" valid="yes" arg="#5F9EA0"><title>#5F9EA0</title><subtitle>CSS • Hexadecimal</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to css-hsl" valid="yes" arg="hsl(182, 25%, 50%)"><title>hsl(182, 25%, 50%)</title><subtitle>CSS • HSL</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ns-calibrated-rgb" valid="yes" arg="[NSColor colorWithCalibratedRed:0.373 green:0.62 blue:0.627 alpha:1]"><title>[NSColor colorWithCalibratedRed:0.373 green:0.62 blue:0.627 alpha:1]</title><subtitle>NSColor • Calibrated RGB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ns-calibrated-hsb" valid="yes" arg="[NSColor colorWithCalibratedHue:0.505 saturation:0.406 brightness:0.627 alpha:1]"><title>[NSColor colorWithCalibratedHue:0.505 saturation:0.406 brightness:0.627 alpha:1]</title><subtitle>NSColor • Calibrated HSB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ns-device-rgb" valid="yes" arg="[NSColor colorWithDeviceRed:0.373 green:0.62 blue:0.627 alpha:1]"><title>[NSColor colorWithDeviceRed:0.373 green:0.62 blue:0.627 alpha:1]</title><subtitle>NSColor • Device RGB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ns-device-hsb" valid="yes" arg="[NSColor colorWithDeviceHue:0.505 saturation:0.406 brightness:0.627 alpha:1]"><title>[NSColor colorWithDeviceHue:0.505 saturation:0.406 brightness:0.627 alpha:1]</title><subtitle>NSColor • Device HSB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ui-rgb" valid="yes" arg="[UIColor colorWithRed:0.373 green:0.62 blue:0.627 alpha:1]"><title>[UIColor colorWithRed:0.373 green:0.62 blue:0.627 alpha:1]</title><subtitle>UIColor • RGB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item><item uid="tylereich.colors css-named to ui-hsb" valid="yes" arg="[UIColor colorWithHue:0.505 saturation:0.406 brightness:0.627 alpha:1]"><title>[UIColor colorWithHue:0.505 saturation:0.406 brightness:0.627 alpha:1]</title><subtitle>UIColor • HSB</subtitle><icon>/Users/joey/Library/Caches/com.runningwithcrayons.Alfred-2/Workfow Data/tylereich.colors/5F9EA0FF.png</icon></item></items>
# XML
# hash = Hash.from_xml(xml)
# p hash

# def hex2rgb(hex)
#   hex.gsub!('#', '')
#   return '0,0,0' if hex == '000'
#   if hex.size == 6
#     f = hex[0..1].to_i(16).to_s
#     s = hex[2..3].to_i(16).to_s
#     t = hex[4..5].to_i(16).to_s
#     return "#{f},#{s},#{t}"
#   else
#     return '255,255,255'  
#   end
# end

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