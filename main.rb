# -*- coding: UTF-8 -*-
begin
  require 'json'
  require_relative './utils/output'
  require_relative './filters/color_filter'
  require_relative './filters/all_keys_filter'
  require_relative './filters/sites_filter'
  require_relative './filters/jira_filter'
  require_relative './filters/str_operation'
  require_relative './filters/url_filters/github_filter'
  require_relative './filters/url_filters/kibana_filter'
  require_relative './filters/ide_filters/vscode_filter'
  require_relative './filters/ide_filters/sublime_filter'
  require_relative './filters/ide_filters/idea_filter'
  require_relative './filters/ide_filters/pycharm_filter'
  require_relative './extension/hash'
  require_relative './extension/string'
  require 'fileutils'

  # Notice: 英文 ',' 来分隔参数
  # ARGV
  params = ARGV[0]
  polishedParams = params.gsub('，', ',')

  category, *args = polishedParams.split(',')

  if args
    if args && args.size != 0
      key, argParams = args
    end
  end

  case category
  when 'color' then ColorFilter.do_filter(key)
  when 'allkeys' then AllKeysFilter.do_filter(key)
  when 'stt' then SitesFilter.do_filter(key, argParams)
  when 'stji', 'jira' then JiraFilter.do_filter(key)
  when 'kia', 'kibana' then KibanaFilter.do_filter(key)
  when 'stgh' then GithubFilter.do_filter(key)
  when 'code' then VscodeFilter.do_filter(key)
  when 'subl' then SublimeFilter.do_filter(key)
  when 'idea' then IdeaFilter.do_filter(key)
  when 'pcm' then PycharmFilter.do_filter(key)
  when 'str_operation' then StrOperationFilter.do_filter(args.join(','))
  when 'single_quoto_str_operation' then SingleQuotoStrOperationFilter.do_filter(args.join(','))
  else
    item = {
      :title => 'Whoop! An unknow keyword.', 
    }
    Output.put(item)
  end
rescue Exception => e
  item = {
    :title => 'SOME ERROR HAPPENED.', 
    :subtitle => "#{e.to_s}",
    :autocomplete => "#{e.to_s}",
  }
  Output.put(item)
end