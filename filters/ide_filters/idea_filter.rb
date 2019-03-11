require_relative './base_filter'

class IdeaFilter < IdeFilter
  class << self
    # def cli_is_exist?
    #   return true
    #   Dir.glob('/Applications/carbon-now-sh for Xcode.app*').empty?
    # end

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