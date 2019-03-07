require_relative '../utils/output'

class VscodeFilter
  ORG_GITHUB_HOST = 'https://github.com/Overseas-Student-Living/'

  class << self
    def do_filter(key)
      # [{:uid=>"desktop", :type=>"file", :title=>"Desktop", :subtitle=>"~/Desktop", :arg=>"~/Music", :autocomplete=>"Desktop", :icon=>{:type=>"fileicon", :path=>"~/Music"}}]
      # Dir.home # => "/Users/joeeey"

      # automplete 带有 xxx/, do filter 中发现 / 结尾发触发 Dir.entries
      # 否则只做过滤


      # current_children_files = Dir.entries(key)
      # a = {}
      # Dir.foreach(Dir.home) do |file|
      #   a[file] = File.directory? file
      #   # puts File.directory? file
      # end

      # p a

      if key && key != ''
        if key[0] == '~'
          # todo
          current_path = "#{Dir.home}/#{key[1..-1]}"
        elsif !key.include?(Dir.home)
          current_path = "#{Dir.home}/#{key}"
        else
          current_path = key
        end
      else
        current_path = "#{Dir.home}/"
        # If key not exist, use '~' path defaultly  
      end
      if current_path[-1] == '/'
        entry_path = current_path
        current_children_files = Dir.entries(entry_path)
        file_name_mapping = {}
        current_children_files.each do |current_children_file|
          file_name_mapping[current_children_file] = current_children_file
        end
        items = get_items('', file_name_mapping, current_path)

        Output.put(items)
      else 
        slash_indexes = (0 ... current_path.length).find_all { |i| current_path[i,1] == '/' }

        last_slash_index = slash_indexes.last
        entry_path = current_path[0..last_slash_index]
        current_children_files = Dir.entries(entry_path)

        file_name_mapping = {}
        current_children_files.each do |current_children_file|
          file_name_mapping[current_children_file] = current_children_file
        end

        filter_key = key[(last_slash_index+1)..-1]
        items = get_items(filter_key, file_name_mapping, current_path)
        Output.put(items)
      end
      return
    end

    # 获取生成 alfred 文档的元素
    def get_items(filter_key, file_name_mapping, current_path)
      # p "get_matched_keys is #{file_name_mapping}, #{filter_key}"
      matchedKeys = get_matched_keys(file_name_mapping, filter_key)
      if matchedKeys.size == 0
        return { :title => "404 NOT FOUND." }
      elsif matchedKeys.size == 1
        matchedKey = matchedKeys[0]
        file_name = file_name_mapping[matchedKey]
        file_path = current_path + file_name
        return {
          :type=>"file", 
          :title=>file_name, 
          :arg=>"#{File.directory?(current_path+file_name) ? (file_path + '/') : file_path}", 
          :autocomplete=>"#{File.directory?(current_path+file_name) ? (file_path + '/') : file_path}", 
          :icon=>{:type=>"fileicon", :path=>file_path}
        }
      else
        items = []
        matchedKeys.each do |matchedKey|
          file_name = file_name_mapping[matchedKey]
          file_path = current_path + file_name
          items <<  {
            :type=>"file",
            :title=>file_name, 
            :arg=>"#{File.directory?(current_path+file_name) ? (file_path + '/') : file_path}", 
            :autocomplete=>"#{File.directory?(current_path+file_name) ? (file_path + '/') : file_path}", 
            :icon=>{:type=>"fileicon", :path=>file_path}
          }    
        end
        return items
      end
    end

    private
    # 根据 input 内容过滤 json 中的 key
    def get_matched_keys(file_name_mapping, filter_key)
      # filter_key = filter_key.downcase
      matchedKeys = []
      if file_name_mapping[filter_key]
        matchedKeys << filter_key
      else
        # 相似匹配
        # TODO 更智能
        file_name_mapping.keys.each do |file_name_mappingKey|
          if file_name_mappingKey.include? filter_key
            matchedKeys << file_name_mappingKey
          end
        end
      end
      return matchedKeys
    end
  end
end