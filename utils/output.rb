require_relative './workflow_xml_wrapper'

class Output
  def self.put(items=[], wrap_xml_key=true)
    xml = WorkflowXmlWrapper.wrap(items, wrap_xml_key)

    puts xml
  end
end