require 'json'
require 'net/http'
require_relative '../utils/output'

# ENV
# 1.dev 2.uat 3.stage 4.prod
class SitesFilter
  CN_API_HOST = 'https://cn.student.com/autocomplete'
  DATA_KEYS = [
    "cities",
    "universities",
    "areas",
    "properties"
  ]
  class << self
    def do_filter(key, args)
      urlMappingJsonString = File.read "./assets/url_mapping.json"
      urlMapping = JSON.parse(urlMappingJsonString)

      if key && key != ''
        items = get_items(key, urlMapping, args)
        Output.put(items)
      else
        items = []
        urlMapping.each {|k, v| items << 
          {
            :title => "#{k.upcase}",
            :subtitle => URI.join(v, "/").to_s,
            :arg => v,
            :autocomplete => k
          }
        }
        Output.put(items)
      end
    end

    # 获取生成 alfred 文档的元素
    def get_items(input_key, urlMapping, args)
      matchedKeys = get_matched_keys(urlMapping, input_key)

      if matchedKeys.size == 0
        return { :title => 'Invalid key.' }
      elsif matchedKeys.size == 1
        matchedKey = matchedKeys[0]
        if args && args.size > 0
          searchResult = get_search_result(args)
          items = []
          searchResult.each do |x|
            items << {
              :title => "#{matchedKey.upcase}: #{x[:name]}",
              :subtitle => "#{URI.join(urlMapping[matchedKey], "/").to_s + x[:suffix][1..1000] }",
              :arg => "#{URI.join(urlMapping[matchedKey], "/").to_s + x[:suffix][1..1000]}"
            }
          end
          return items if items.size > 0
          return { :title => 'Nothing found. Invalid serach term.' } 
        else
          return {
            :title => matchedKey.upcase,
            :subtitle => "press ENTER to go, or use ', {searchTerm' to search",
            :arg => urlMapping[matchedKey],
            :autocomplete => matchedKey
          }   
        end
      else
        items = []
        matchedKeys.each do |matchedKey|
          items << {
            :title => "#{matchedKey.upcase}",
            :subtitle => "press ENTER to go",
            :arg => "#{urlMapping[matchedKey]}",
            :autocomplete => matchedKey
          }       
        end
        return items
      end
    end

    private
    # 获得 api 请求的结果
    def get_search_result(args)
      city, university = args
      path = "?term=#{URI::encode(city)}"
      url = CN_API_HOST + path
      uri = URI.parse(url)
      body = JSON.parse(Net::HTTP.get(uri))
      return wrap_url_suffix(body)
    end

    def wrap_url_suffix(body)
      urlSuffix = []
      DATA_KEYS.each do |data_key|
        data = body[data_key] || body[data_key.to_sym]
        urlSuffix += data.map do |x|
          countrySlug = x['country']['slug']
          citySlug = x['city']['slug'] if x['city'] 
          selfSlug = x['slug']
          suffix = case data_key
                   when 'universities'
                    "/#{countrySlug}/#{citySlug}/u/#{selfSlug}"
                   when 'cities'
                    "/#{countrySlug}/#{selfSlug}"
                   when 'areas' 
                    "/#{countrySlug}/#{citySlug}/#{selfSlug}"
                   when 'properties' 
                    "/#{countrySlug}/#{citySlug}/p/#{selfSlug}"
                   end

          x = {
            suffix: suffix,
            name: x['name']
          }
        end
      end
      return urlSuffix
    end
    
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