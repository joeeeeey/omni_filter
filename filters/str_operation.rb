require_relative '../utils/output'

class StrOperationFilter
  METHODS_LIST = [
    {display_name: 'base64_decode', proxy_method: 'base64_decode', des: 'base64 decode.' },
    {display_name: 'base64_encode', proxy_method: 'base64_encode', des: 'base64 encode.' },
    {display_name: 'uppercase', proxy_method: 'upcase', des: 'Upcase.'},
    {display_name: 'downcase', proxy_method: 'downcase', des: 'Downcase.' },
    # {display_name: 'camel_case_capital', proxy_method: 'camel_case_capital', des: 'Convert to Camel case' },
    {display_name: 'camel_case_lower', proxy_method: 'camel_case_lower', des: 'Camel case with lower letter start.' },
    {display_name: 'underscore', proxy_method: 'underscore', des: 'underscore' },
    # {display_name: 'lower', proxy_method: 'downcase', des: 'Downcase.' },
    # {display_name: 'daxie', proxy_method: 'upcase', des: 'Upcase.' },
    # {display_name: 'xiaoxie', proxy_method: 'downcase', des: 'Downcase.' },
    # {display_name: 'xiahuaxian', proxy_method: 'underscore', des: 'underscore.' },
  ]

  METHODS_MAPPING = {}
  METHODS_LIST.each { |x| METHODS_MAPPING[x[:display_name]] = x }

  class << self
    def get_icon
      {
        :path => "doughnut.png"
      }
    end

    def do_filter(key)
      if key && key != ''
        items = get_items(key)
        Output.put(items)
      else
        item = {
          :title => "Waiting input..",
          :icon => get_icon,
        }
        Output.put(item)
      end
    end

    def opeation_directive
      return "\""
    end

    # 获取生成 alfred 文档的元素
    def get_items(input_key)
      double_quot_count = input_key.count(opeation_directive)
      pattern = /#{opeation_directive}/
      if double_quot_count.odd?
        # Find the last index of "
        # and the right character is .
        last_quot_index = input_key.rindex(pattern)
        if input_key[last_quot_index+1] == '.'
          opeation_str = input_key[0..last_quot_index-1]
          items = []
          fn_args = input_key[(last_quot_index+2)..10000]

          matched_keys = get_matched_keys(StrOperationFilter::METHODS_MAPPING, fn_args)

          extracted_methods_mapping = 
            StrOperationFilter::METHODS_MAPPING.extract_subhash(*matched_keys)
          
          items = extracted_methods_mapping.values

          if items.size == 0
            items = [{ :title => "This method is not provided", :icon => get_icon }]
          elsif items.size == 1
            # do the method
            result = opeation_str.send(items[0][:proxy_method])
            items = {
              :title => "#{result}",
              # :subtitle => "type COMMAND+C or ENTER to copy result",
              :arg => result,
              :autocomplete => input_key[0..last_quot_index+1] + items[0][:display_name],
              :icon => get_icon,
            }
          else
            return items.map {|x| 
              result = opeation_str.send(x[:proxy_method])
              {
              :title => x[:display_name],
              :subtitle => "Result is: #{result}",
              :arg => result,
              :autocomplete => input_key[0..last_quot_index+1] + x[:display_name],
              :icon => get_icon,
            }
           }
          end
        else
          items = [{ :title => "Waiting input..", :icon => get_icon, }]
        end
      else
        items = [{ :title => "Waiting input..", :icon => get_icon, }]
      end
      return items
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
    def get_matched_keys(mapping_data, filter_key)
      matchedKeys = []
      reg_str = similar_match filter_key.downcase
      mapping_data.keys.each do |mapping_key|
        if mapping_key.downcase[Regexp.new reg_str]
          if mapping_data[filter_key] && filter_key == mapping_key
            matchedKeys.unshift(mapping_key)
          else
            matchedKeys << mapping_key
          end
        end
      end
      return matchedKeys
    end
  end
end

class SingleQuotoStrOperationFilter < StrOperationFilter
  class << self
    def opeation_directive
      return "\'"
    end
  end
end