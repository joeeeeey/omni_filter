require 'json'
require_relative '../utils/output'

class ColorFilter
	DEFAULT_KEY = '#000'
	class << self
		def do_filter(key)
  	  colorMappingJsonString = File.read "./assets/colorNameMapping.json"
  		colorMapping = JSON.parse(colorMappingJsonString)

      if key && key != ''
        items = get_items(key, colorMapping)
        Output.put(items)     
      else
        items = []
        colorMapping.each {|k, v| items << {:title => "#{k} : #{v}"}}
        Output.put(items)        
      end
		end

		def get_items(key, colorMapping)
      # 完全相等直接返回单个
      return {
               :title => colorMapping[key],
               :subtitle => "#{key}: use ENTER or CMD+C to paste",
               :@arg => colorMapping[key]
             } if colorMapping[key]

			return {
               :title => colorMapping["##{key}"],
               :subtitle => "##{key}: use ENTER or CMD+C to paste",
               :@arg => colorMapping["##{key}"]
             } if colorMapping["##{key}"]

      # 相似匹配，过滤后返回列表
      similar_keys = []
      items = []
      colorMapping.keys.each do |colorMappingKey|
        if colorMappingKey.include? key
          similar_keys << key
          items << {
            :title => colorMapping[colorMappingKey],
            :subtitle => "#{colorMappingKey}: use ENTER or CMD+C to paste",
            :@arg => colorMapping[colorMappingKey]
          }
        end
      end

      if items.size > 0
        return items
      else 
        return [{
          :title => '不存在', 
        }]          
      end
		end
	end
end

