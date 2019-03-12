require 'json'
require_relative '../utils/output'

class ColorFilter
	class << self
		def do_filter(key)
  	  colorMappingJsonString = File.read "./assets/color_name_mapping.json"
  		colorMapping = JSON.parse(colorMappingJsonString)

      if key && key != ''
        items = get_items(key, colorMapping)
        Output.put(items)
      else
        items = []
        colorMapping.each {|k, v| items << {
          :title => "#{k} : #{v}",
          :autocomplete => k
          }
        }
        Output.put(items)
      end
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
      items = whole_xml['items'] || whole_xml[:items]
      item = items['item'] || items[:item]
      item.each {|x| x[:icon] = { :path => x[:icon] } }
      item.unshift({
        title: colorValue,
        subtitle: "#{key}: use ENTER or CMD+C to paste",
        arg: colorValue,
      })
      return item
    end

    def get_items(key, colorMapping)
      # 完全相等直接返回单个, 颜色显示
      if colorMapping[key] 
        return get_fully_equal_item(key, colorMapping)
      end

      if colorMapping["##{key}"]
        return get_fully_equal_item("##{key}", colorMapping)
      end

      # 相似匹配，过滤后返回列表
      similar_keys = []
      items = []
      colorMapping.keys.each do |colorMappingKey|
        if colorMappingKey.include? key
          similar_keys << key
          items << {
            :title => colorMapping[colorMappingKey],
            :subtitle => "#{colorMappingKey}: use ENTER or CMD+C to paste",
            :arg => colorMapping[colorMappingKey],
            :autocomplete => colorMappingKey,
          }
        end
      end

      if items.size > 0
        return items
      else 
        return [
          {
            :title => 'Invalid key.',
          }
        ]  
      end
		end
	end
end

