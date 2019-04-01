require_relative './ide_base_filter'

class PycharmFilter < IdeBaseFilter
  class << self
    def app_is_not_installed?
      Dir.glob('/Applications/PyCharm.app*').empty?
    end

    def get_cli_missing_output
      return {
        :title => "Can't find the `pcm` cli for PYCharm.",
        :subtitle => "press SHIFT+ENTER go to offical install doc.",
        :arg => "https://www.jetbrains.com/pycharm/",
        :autocomplete => "https://www.jetbrains.com/pycharm/"
      }
    end
  end
end