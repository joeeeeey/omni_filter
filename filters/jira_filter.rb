require 'json'
require_relative '../utils/output'

class JiraFilter
  JIRA_HOST = 'https://oslcorp.atlassian.net/browse/'  

  class << self
    def do_filter(key)
      cache_dir_path = File.expand_path('~/Library/Caches/student.com.workflow.alfred')

      # mkdir if dir is not exsit
      FileUtils.mkdir_p(cache_dir_path) unless File.directory?(cache_dir_path)

      file_name = "#{cache_dir_path}/jira.json"

      # If file is not exsit, write default json data '{}' into it.
      unless File.file?(file_name)
        File.open(file_name,"w") do |f|
          f.write({}.to_json)
        end
      end

      file = File.read file_name
      cache_data = JSON.parse(file)

      # 满足 ticket number 验证并且不在 cache 中则加入该 key
      if key && key.length == 4 && key.to_i > 3000 && key.to_i < 7500
        unless cache_data[key]
          cache_data[key] = {created_at: Time.now}
          File.open(file_name,"w") do |f|
            f.write(cache_data.to_json)
          end
        end
      end

      items = []
      if key && key != ''
        items = get_items(key, cache_data)
        # 搜索了不符合条件的 ticket 号
        # 允许跳转?
        if items.size == 0
          items = [
            {
              :title => "#{JIRA_HOST}ZEN-#{key}",
              :subtitle => "Ticket number '#{key}' maynot valid. But you can still press enter and go.",
              :arg => "#{JIRA_HOST}ZEN-#{key}"
            }
          ]
        end
        Output.put(items)
      else
        if cache_data.keys.size == 0
          items << {
            :title => "No search histroy",
            :subtitle => "Begin search...",
          }
        else 
          cache_data.each {|k, v| items << {
            :title => "ZEN-#{k}",
            :subtitle => "First search at: " + (v[:created_at] || v['created_at']),
            :arg => "#{JIRA_HOST}ZEN-#{k}"
          }}
        end

        Output.put(items)
      end
    end

    # 获取生成 alfred 文档的元素
    def get_items(input_key, cache_data)
      matched_keys = get_matched_keys(input_key, cache_data)
      items = []
      matched_keys.each do |k|
        items << {
          :title => "#{JIRA_HOST}ZEN-#{k}",
          :subtitle => cache_data[k][:created_at] || cache_data[k]['created_at'],
          :arg => "#{JIRA_HOST}ZEN-#{k}"
        }
      end
      return items
    end

    # 根据 input 内容过滤 json 中的 key
    def get_matched_keys(input_key, cache_data)
      return [input_key] if cache_data[input_key]

      matched_keys = []

      cache_data.each do |k, _|
        if k.include? input_key
          matched_keys << k
        end
      end

      return matched_keys
    end

  end
end