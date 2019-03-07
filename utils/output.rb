require_relative './workflow_xml_wrapper'

class Output
  def self.put(items=[])
    if items.is_a? Hash
      jsonStr = {items: [items]}.to_json
    else
      jsonStr = {items: items}.to_json  
    end

    puts jsonStr

    # a = {:items=>[{:uid=>"desktop", :type=>"file", :title=>"Desktop", :subtitle=>"~/Desktop", :arg=>"~/Music", :autocomplete=>"Desktop", :icon=>{:type=>"fileicon", :path=>"~/Music"}}]}
    # puts a.to_json
  end
end