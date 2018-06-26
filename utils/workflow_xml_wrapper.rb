# This wapper is used to convert hash data to alfred xml format data.

require 'json'

class WorkflowXmlWrapper
	def self.wrap(items=[])
    items = [items] if items.is_a? Hash

		return get_xml_workflow_xml(items)
	end

	def self.get_items_xml_str(items)
		str = ''
		items.each do |item|
			str +=  "<item #{item[:@arg] ? "arg=#{'"' + item[:@arg] + '"'}" : ''}>" +
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