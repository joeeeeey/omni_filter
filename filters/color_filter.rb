require 'gyoku'
require 'json'


class ColorFilter
	DEFAULT_KEY = '#000'
	class << self
		def do_filter
		colorMappingJsonString = File.read "./assets/colorNameMapping.json"
		colorMapping = JSON.parse(colorMappingJsonString)

		key = ARGV[0] || DEFAULT_KEY

		value = get_value(key, colorMapping) || '不存在'


		hash = {
			xml: {
				items: {
					item: {}
				}
			}
		}


		item = {
			:title => value, # 
			:subtitle => 'use ENTER or COMMAND+C to paste',
			:@arg => value # Use for copying in the clipboard. In order for Alfred workflow objects after the script filter to receive data, we must specify the arg property in the XML item nodes:
		}

		hash[:xml][:items][:item] = item

		xml = Gyoku.xml(hash)

		puts xml      
		end

		def get_value(key, colorMapping)
			return colorMapping[key] || colorMapping["##{key}"]
		end
	end
end


