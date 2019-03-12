require_relative './ide_base_filter'

class IdeaFilter < IdeBaseFilter
  class << self
    def app_is_not_installed?
      Dir.glob('/Applications/IntelliJ IDEA CE.app*').empty?
    end

    def get_cli_missing_output
      return {
        :title => "Can't find the `idea` cli for IDEA.",
        :subtitle => "press SHIFT+ENTER go to offical install doc.",
        :arg => "https://www.jetbrains.com/help/idea/install-and-set-up-product.html",
        :autocomplete => "https://www.jetbrains.com/help/idea/install-and-set-up-product.html"
      }
    end
  end
end