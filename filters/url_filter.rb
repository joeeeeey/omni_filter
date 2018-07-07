require 'json'
require_relative '../utils/output'

class UrlFilter
  class << self
    def do_filter(key)
      urlMappingJsonString = File.read "./assets/urlMapping.json"
      urlMapping = JSON.parse(urlMappingJsonString)

      if key && key != ''
        items = get_items(key, urlMapping)
        Output.put(items)
      else
        items = []
        urlMapping.each {|k, v| items << {:title => "#{k.upcase}"}}
        Output.put(items)        
      end
    end

    def get_items(key, urlMapping)
      # 完全相等直接返回单个
      return {
               :title => key.upcase,
               :subtitle => "#{key}: press ENTER to go",
               :@arg => urlMapping[key]
             } if urlMapping[key]

      # 相似匹配，过滤后返回列表
      similar_keys = []
      items = []
      urlMapping.keys.each do |urlMappingKey|
        if urlMappingKey.include? key
          similar_keys << key
          items << {
            :title => "#{urlMappingKey.upcase}",
            :subtitle => "press ENTER to go",
            :@arg => "#{urlMapping[urlMappingKey]}"
          }
        end
      end

      if items.size > 0
        return items
      else 
        return [{
          :title => 'Invalid key.', 
        }]          
      end
    end
  end
end