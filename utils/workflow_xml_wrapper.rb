# This wapper is used to convert hash data to alfred xml format data.

require 'json'

class WorkflowXmlWrapper
	def self.wrap(items=[], wrap_xml_key)
    items = [items] if items.is_a? Hash

    return get_xml_from_hash(items, wrap_xml_key)
		# return get_xml_workflow_xml(items)
	end

	# def self.get_items_xml_str(items)
	# 	str = ''
	# 	items.each do |item|
	# 		str +=  "<item #{item[:@arg] ? "arg=#{'"' + item[:@arg] + '"'}" : ''}>" +
	# 						"<title>#{item[:title]}</title>" + 
	# 						"<subtitle>#{item[:subtitle]}</subtitle>" +
	# 						"</item>"
	# 	end
	# 	return str
  # end

  # convert from hash
  def self.get_xml_from_hash(items, wrap_xml_key)
    items = items.map do |x|
       {
         arg: x[:@arg],
         title: x[:title],
         subtitle: x[:subtitle]
       }
    end if wrap_xml_key

    xml_str = { "items" => { "item" => items } }.to_xml.gsub( / *\n+/, "" )

    return xml_str
  end

	# def self.get_xml_workflow_xml(items)
  #   xml_str = "<xml><items>#{get_items_xml_str(items)}</item></items></xml>"

	# 	return xml_str.gsub( / *\n+/, "" ).gsub( / *\"+/, "'" )
	# end
end