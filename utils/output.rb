require_relative './workflow_xml_wrapper'

class Output
  def self.put(items=[])
    xml = WorkflowXmlWrapper.wrap(items)

    puts xml
  end
end