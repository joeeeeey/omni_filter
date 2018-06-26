# This wapper is used to convert hash data to alfred xml format data.

require 'gyoku'
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
      hash[:xml][:items][:item] = items
    elsif items.is_a? Array
      if items.size == 1
        hash[:xml][:items][:item] = items[0]
      else
        hash[:xml][:items][:item] = items
      end     
    end

	  return xml = Gyoku.xml(hash)
	end
end