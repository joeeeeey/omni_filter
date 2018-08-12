require_relative '../utils/output'

class GithubFilter
  ORG_GITHUB_HOST = 'https://github.com/Overseas-Student-Living/'

  class << self
    def do_filter(key)
      urlMappingJsonString = File.read "./assets/github_url.json"
      urlMapping = JSON.parse(urlMappingJsonString)

      if key && key != ''
        items = get_items(key, urlMapping)
        Output.put(items)
      else
        items = []
        urlMapping.each {|k, v| items << 
          {
            :title => k,
            :subtitle => "Press enter to go: #{ORG_GITHUB_HOST + v}",
            :arg => "#{ORG_GITHUB_HOST + v}",
            :autocomplete => k
          }
        }
        Output.put(items)
      end
    end

    # 获取生成 alfred 文档的元素
    def get_items(input_key, urlMapping)
      matchedKeys = get_matched_keys(urlMapping, input_key)

      if matchedKeys.size == 0
        return { :title => 'Invalid key.' }
      elsif matchedKeys.size == 1
        matchedKey = matchedKeys[0]
        return {
          :title => matchedKey,
          :subtitle => "Press enter to go: #{ORG_GITHUB_HOST + urlMapping[matchedKey]}",
          :arg => "#{ORG_GITHUB_HOST + urlMapping[matchedKey]}",
          :autocomplete => matchedKey    
        }
      else
        items = []
        matchedKeys.each do |matchedKey|
          items << {
            :title => "#{matchedKey.upcase}",
            :subtitle => "Press enter to go: #{ORG_GITHUB_HOST + urlMapping[matchedKey]}",
            :arg => "#{ORG_GITHUB_HOST + urlMapping[matchedKey]}",
            :autocomplete => matchedKey
          }       
        end
        return items
      end
    end

    private
    # 根据 input 内容过滤 json 中的 key
    def get_matched_keys(urlMapping, input_key)
      input_key = input_key.downcase
      matchedKeys = []
      if urlMapping[input_key]
        matchedKeys << input_key
      else
        # 相似匹配
        # TODO 更智能
        urlMapping.keys.each do |urlMappingKey|
          if urlMappingKey.include? input_key
            matchedKeys << urlMappingKey
          end
        end
      end
      return matchedKeys
    end
  end
end