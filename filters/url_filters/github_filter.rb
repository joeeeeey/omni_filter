require_relative './url_base_filter'

class GithubFilter < UrlBaseFilter
  ORG_GITHUB_HOST = 'https://github.com/Overseas-Student-Living/'
  class << self
    def get_mapping_value(v)
      ORG_GITHUB_HOST + v
    end

    def mapping_file_path
      "./assets/github_url.json"
    end

    def get_icon
      {
        :path => "github_logo.png"
      }
    end
  end
end

class G6GFilter < UrlBaseFilter
  ORG_GITHUB_HOST = 'https://github.com/Project-G66-Org/'
  class << self
    def get_mapping_value(v)
      ORG_GITHUB_HOST + v
    end

    def mapping_file_path
      "./assets/g6g_url.json"
    end

    def get_icon
      {
        :path => "github_logo.png"
      }
    end
  end
end