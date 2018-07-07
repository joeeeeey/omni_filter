require 'json'
require_relative '../utils/output'

class AllKeysFilter
  class << self
    def do_filter(key)
      allKeysMappingJsonString = File.read "./assets/all_variables.json"
      allKeysMapping = JSON.parse(allKeysMappingJsonString)

      if key && key != ''
        items = get_items(key, allKeysMapping)
        Output.put(items)
      else
        items = []
        allKeysMapping.each {|k, v| items << {:title => "#{k} : #{v}"}}
        Output.put(items)        
      end
    end

    def get_items(key, allKeysMapping)
      # 完全相等直接返回单个
      return {
               :title => allKeysMapping[key],
               :subtitle => "#{key}: use ENTER or CMD+C to paste",
               :@arg => allKeysMapping[key]
             } if allKeysMapping[key]

      return {
               :title => allKeysMapping["##{key}"],
               :subtitle => "##{key}: use ENTER or CMD+C to paste",
               :@arg => allKeysMapping["##{key}"]
             } if allKeysMapping["##{key}"]

      # 相似匹配，过滤后返回列表
      similar_keys = []
      items = []
      allKeysMapping.keys.each do |allKeysMappingKey|
        if allKeysMappingKey.include? key
          similar_keys << key
          items << {
            :title => "#{allKeysMappingKey}: #{allKeysMapping[allKeysMappingKey]}",
            :subtitle => "use ENTER or CMD+C to paste",
            :@arg => "#{allKeysMappingKey}: #{allKeysMapping[allKeysMappingKey]}"
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