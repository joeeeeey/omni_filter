require_relative './base_filter'

class SublimeFilter < IdeFilter
  class << self
    def cli_is_exist?
      return File.exist? '/usr/local/bin/subl'
    end

    def get_cli_missing_output
      return {
        :title => "Can't find the `subl` cli for vscode.",
        :subtitle => "press SHIFT+ENTER go to offical install doc.",
        :arg => "https://code.visualstudio.com/docs/setup/mac",
        :autocomplete => "https://code.visualstudio.com/docs/setup/mac"
      }
    end
  end
end