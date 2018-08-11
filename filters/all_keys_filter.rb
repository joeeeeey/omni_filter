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
        allKeysMapping.each {|k, v| items << {
            :title => "#{k} : #{v}",
            :autocomplete => k
          }
        }
        Output.put(items)        
      end
    end

    def get_items(key, allKeysMapping)
      if allKeysMapping[key]
        return get_fully_equal_item(key, allKeysMapping) if isColor?(allKeysMapping[key])
        return {
          :title => allKeysMapping[key],
          :subtitle => "#{key}: use ENTER or CMD+C to paste",
          :arg => allKeysMapping[key]
        }
      end

      if allKeysMapping["##{key}"]
        return get_fully_equal_item("##{key}", allKeysMapping)  if isColor?(allKeysMapping["##{key}"])
        return {
          :title => allKeysMapping["##{key}"],
          :subtitle => "##{key}: use ENTER or CMD+C to paste",
          :arg => allKeysMapping["##{key}"]
        }       
      end


      # 相似匹配，过滤后返回列表
      similar_keys = []
      items = []
      allKeysMapping.keys.each do |x|
        if x.include? key
          similar_keys << key
          items << {
            :title => "#{x}: #{allKeysMapping[x]}",
            :subtitle => "use ENTER or CMD+C to paste",
            :arg => "#{x}: #{allKeysMapping[x]}",
            :autocomplete => x
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

    def isColor?(value)
      value.to_s.include?('color-')
    end

    def hex2rgb(hex)
      hex.gsub!('#', '')
      return '0,0,0' if hex == '000'
      if hex.size == 6
        f = hex[0..1].to_i(16).to_s
        s = hex[2..3].to_i(16).to_s
        t = hex[4..5].to_i(16).to_s
        return "#{f},#{s},#{t}"
      else
        return '255,255,255'
      end
    end
    
    def get_fully_equal_item(key, colorMapping)
      colorValue = colorMapping[key]
      value = `cd color && ./colors 'rgb #{hex2rgb(key)}'`
      whole_xml = Hash.from_libxml(value)

      # Hash.from_libxml may return hash key mixed with symbol and string.
      items = whole_xml['items'] || whole_xml[:items]
      item = items['item'] || items[:item]
      item.unshift({
        title: colorValue,
        subtitle: "#{key}: use ENTER or CMD+C to paste",
        arg: colorValue,
      })

      return item
    end

  end
end