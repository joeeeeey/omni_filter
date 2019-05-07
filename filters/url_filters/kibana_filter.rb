require_relative './url_base_filter'

class KibanaFilter < UrlBaseFilter
  class << self
    def get_mapping_value(v)
      v
    end

    def mapping_file_path
      "./assets/kibana_url.json"
    end
    
    def get_icon
      {
        :path => "kibana_logo.png"
      }
    end
  end
end
