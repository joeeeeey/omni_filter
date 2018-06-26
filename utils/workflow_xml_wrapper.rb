# This wapper is used to convert hash data to alfred xml format data.

# require 'gyoku'
require 'json'

class WorkflowXmlWrapper
	def self.wrap(items=[])
	  hash = {
	    xml: {
	      items: {
	        item: {}
	      }
	    }
	  }

    if items.is_a? Hash
      hash[:xml][:items][:item] = [items]
    elsif items.is_a? Array
			hash[:xml][:items][:item] = items	    
		end
		
		return get_xml_workflow_xml(items)
	  # return Gyoku.xml(hash)
	end

	def self.get_items_xml_str(items)
		str = ''
		items.each do |item|
			str += 
"<item #{item[:@arg] ? "arg=#{'"' + item[:@arg] + '"'}" : ''}>" +
"<title>#{item[:title]}</title>" + 
"<subtitle>#{item[:subtitle]}</subtitle>" +
"</item>"
		end
		return str
	end

	def self.get_xml_workflow_xml(items)
		xml_str = "<xml><items>#{get_items_xml_str(items)}</item></items></xml>"
		return xml_str.gsub( / *\n+/, "" )
	end
end