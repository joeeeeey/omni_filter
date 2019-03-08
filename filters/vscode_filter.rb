require_relative '../utils/output'

class VscodeFilter
  INVALID_PATH_CONTENT = { :title => "Can't find the file or directory with current path of" }
  class << self
    def do_filter(key)
      # Check `code` cli
      if !File.exist? '/usr/local/bin/code'
        Output.put({
          :title => "Can't find the `code` cli for vscode.",
          :subtitle => "press SHIFT+ENTER go to offical install doc.",
          :arg => "https://code.visualstudio.com/docs/setup/mac",
          :autocomplete => "https://code.visualstudio.com/docs/setup/mac"
        })
        return
      end

      # automplete 带有 xxx/, do filter 中发现 / 结尾发触发 Dir.entries
      # 否则只做过滤
      if key && key != ''
        # 若不满足一下三种情况，将用户输入的 key 增加 `Dir.home` 的前缀
        if !key.downcase.include?(Dir.home.downcase) &&
           !(key[0] == '/' && Dir.home.downcase.include?(key.downcase)) &&
           key[0] != '/'
          key = "#{Dir.home}/#{key}"
        end
      else
        # If key not exist, use `~` path defaultly
        key = "#{Dir.home}/"
      end
      if key[-1] == '/'
        entry_path = key

        if !File.exist?(entry_path)
          Output.put(get_invalid_path_msg(entry_path))
          return
        end
        file_name_mapping = get_file_mapping(entry_path)
        items = get_items('', file_name_mapping, key)

        Output.put(items)
      else
        slash_indexes = (0 ... key.length).find_all { |i| key[i,1] == '/' }

        last_slash_index = slash_indexes.last
        entry_path = key[0..last_slash_index]

        filter_key = key[(last_slash_index+1)..-1]

        if !File.exist?(entry_path)
          Output.put(get_invalid_path_msg(entry_path))
          return
        end
        file_name_mapping = get_file_mapping(entry_path)

        items = get_items(filter_key, file_name_mapping, entry_path)
        Output.put(items)
      end
    end

    def get_invalid_path_msg(path)
      return { :title => "Can't find path of #{path}" }
    end

    def get_file_mapping(entry_path)
      current_children_files = Dir.entries(entry_path).sort

      # hidden_files is file or dir begin with `.`
      hidden_files = current_children_files.select { |x| x[0]=='.' }
      explicit_files = current_children_files - hidden_files
      current_children_files = explicit_files + hidden_files

      file_name_mapping = {}
      current_children_files.each do |current_children_file|
        file_name_mapping[current_children_file] = current_children_file
      end
      return file_name_mapping
    end

    # 获取生成 alfred 文档的元素
    def get_items(filter_key, file_name_mapping, key)
      matchedKeys = get_matched_keys(file_name_mapping, filter_key)
      if matchedKeys.size == 0
        return get_invalid_path_msg(key + filter_key)
      elsif matchedKeys.size == 1
        matchedKey = matchedKeys[0]

        item = get_hash_item(matchedKey, file_name_mapping, key)
        return item
      else
        items = []
        matchedKeys.each do |matchedKey|
          item = get_hash_item(matchedKey, file_name_mapping, key)
          items << item
        end
        return items
      end
    end

    private
    def get_hash_item(matchedKey, file_name_mapping, key)
      file_name = file_name_mapping[matchedKey]
      file_path = key + file_name
      return {
        # :type=>"file", // annotation this to disable shoft preview
        :title=>file_name,
        :arg=>"#{File.directory?(key+file_name) ? (file_path) : file_path}", 
        :autocomplete=>"#{File.directory?(key+file_name) ? (file_path) : file_path}", 
        :icon=>{:type=>"fileicon", :path=>file_path}
      }
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
    def get_matched_keys(file_name_mapping, filter_key)
      matchedKeys = []
        reg_str = similar_match filter_key.downcase
        file_name_mapping.keys.each do |file_name_mapping_key|
        if file_name_mapping_key.downcase[Regexp.new reg_str]
          if file_name_mapping[filter_key] && filter_key == file_name_mapping_key
            matchedKeys.unshift(file_name_mapping_key)
          else
            matchedKeys << file_name_mapping_key
          end
        end
      end
      return matchedKeys
    end
  end
end