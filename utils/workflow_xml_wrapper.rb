# This wapper is used to convert hash data to alfred xml format data.
require 'json'

class WorkflowXmlWrapper
	def self.wrap(items=[], wrap_xml_key)
    items = [items] if items.is_a? Hash

    return get_xml_from_hash(items, wrap_xml_key)
	end

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
end