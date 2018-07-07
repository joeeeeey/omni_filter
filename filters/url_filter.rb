require 'json'
require_relative '../utils/output'
require 'net/http'

# ENV
# 1.dev 2.uat 3.stage 4.prod
class UrlFilter
  API_HOST = 'https://cn.student.com/autocomplete'
  class << self
    def do_filter(key, args)
      urlMappingJsonString = File.read "./assets/urlMapping.json"
      urlMapping = JSON.parse(urlMappingJsonString)

      if key && key != ''
        items = get_items(key, urlMapping, args)
        Output.put(items)
      else
        items = []
        urlMapping.each {|k, v| items << {:title => "#{k.upcase}"}}
        Output.put(items)        
      end
    end

    def get_search_result(args)
      city, university = args
      # baseurl = URI.join(url, "/").to_s

      path = "?term=#{city}"
      url = API_HOST + path
      uri = URI.parse(url)

      body = JSON.parse(Net::HTTP.get(uri))

      # prefix only for universities
      # TODO: for area, for city
      universities = body['universities'] || body[:universities]

      urlSuffix = []
      urlSuffix = universities.map do |x|
        countrySlug = x['country']['slug']
        citySlug = x['city']['slug']
        universitySlug = x['slug']
        x = { 
          suffix: "/#{countrySlug}/#{citySlug}/u/#{universitySlug}",
          name: x['name']
        }
      end
      return urlSuffix
    end

    # TODO
    # 完全匹配与匹配结果为 1 个同样处理
    # 都应进行后续 serach
    def get_items(key, urlMapping, args)
      if urlMapping[key]
        # key 完全匹配
        if args && args.size > 0
          searchResult = get_search_result(args)
          items = []
          searchResult.each do |x|
            items << {
              :title => "#{key.upcase}: #{x[:name]}",
              :subtitle => "press ENTER to go",
              :@arg => "#{urlMapping[key] + x[:suffix]}"
            }
          end
          if items.size > 0
            return items
          else
            return {
              :title => 'Nothing found. Invalid serach term.',
              :subtitle => "press ENTER to go",
              :@arg => urlMapping[key]
            }
          end
        else 
          return {
            :title => key.upcase,
            :subtitle => "press ENTER to go",
            :@arg => urlMapping[key]
          }
        end
      end

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