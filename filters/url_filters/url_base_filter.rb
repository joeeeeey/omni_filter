require_relative '../../utils/output'

class UrlBaseFilter
  class << self
    def get_mapping_value(v)
      "value...."
    end

    def mapping_file_path
      "../../assets/github_url.json"
    end

    def get_icon
    end

    def do_filter(key)
      urlMappingJsonString = File.read mapping_file_path
      urlMapping = JSON.parse(urlMappingJsonString)

      if key && key != ''
        items = get_items(key, urlMapping)
        Output.put(items)
      else
        items = []
        urlMapping.each {|k, v| items << 
          {
            :title => k,
            :subtitle => "Press enter to go: #{get_mapping_value(v)}",
            :arg => "#{get_mapping_value(v)}",
            :autocomplete => k,
            :icon => get_icon
          }
        }
        Output.put(items)
      end
    end

    # 获取生成 alfred 文档的元素
    def get_items(input_key, urlMapping)
      matchedKeys = get_matched_keys(urlMapping, input_key)

      if matchedKeys.size == 0
        return { :title => 'Invalid key.', :icon => get_icon }
      elsif matchedKeys.size == 1
        matchedKey = matchedKeys[0]
        return {
          :title => matchedKey,
          :subtitle => "Press enter to go: #{get_mapping_value(urlMapping[matchedKey])}",
          :arg => "#{get_mapping_value(urlMapping[matchedKey])}",
          :autocomplete => matchedKey,
          :icon => get_icon
        }
      else
        items = []
        matchedKeys.each do |matchedKey|
          items << {
            :title => "#{matchedKey.upcase}",
            :subtitle => "Press enter to go: #{get_mapping_value(urlMapping[matchedKey])}",
            :arg => "#{get_mapping_value(urlMapping[matchedKey])}",
            :autocomplete => matchedKey,
            :icon => get_icon
          }       
        end
        return items
      end
    end

    # Split the string and check left right side is matched.
    # Make sure str is existed
    # str = "(.*?)A(.*?)p(.*?)l(.*?)n(.*?)s(.*?)"
    # 'Applications'[Regexp.new str]
    def similar_match str
      if !str || str == ''
        return Regexp.new('.*')
      end
      str_array = str.split('')
      reg_str = '(.*?)'
      str_array.each do |x|  
        reg_str += "#{x}(.*?)"
      end

      return reg_str
    end

    # 根据 input 内容过滤 json 中的 key
    def get_matched_keys(urlMapping, filter_key)
      matchedKeys = []
      reg_str = similar_match filter_key.downcase
      urlMapping.keys.each do |url_mapping_key|
        if url_mapping_key.downcase[Regexp.new reg_str]
          if urlMapping[filter_key] && filter_key == url_mapping_key
            matchedKeys.unshift(url_mapping_key)
          else
            matchedKeys << url_mapping_key
          end
        end
      end
      return matchedKeys
    end
  end
end