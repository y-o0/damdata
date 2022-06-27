require 'pathname'
require 'time'
require_relative './aggregator'

class Generator
  class << self
    def execute
      File.read(File.expand_path('../../templates/index.html', __FILE__))
          .gsub('<!--  snapshots here  -->', snapshot_links)
          .gsub('<!--  jsons here  -->', json_links)
          .gsub('INFO_FORMATTED_JSON', File.read(File.expand_path('../../settings/pointinfo.json', __FILE__)))
          .gsub('FORMATTED_JSON', Aggregator.convert)
          .then do |replaced_content|
        File.open(File.expand_path('../../index.html', __FILE__), 'w') do |writer|
          writer << replaced_content
        end
      end
    end


    private

    def snapshot_links
      Dir.glob(File.expand_path('../../snapshots/*.html', __FILE__)).sort.reverse.map do |path|
        basename =  Pathname(path).basename
        matched = basename.to_s.match(/(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})(\d{2})/)
        next if matched[1].to_i < 2022
        "<li><a href=\"./snapshots/#{basename}\">取得日 #{matched[1]}年#{matched[2]}月#{matched[3]}日 #{matched[4]}:#{matched[5]}分</a></li>"
      end.compact.join("\n")
    end

    def json_links
      Dir.glob(File.expand_path('../../jsons/*.json', __FILE__)).sort.reverse.map do |path|
        basename =  Pathname(path).basename
        matched = basename.to_s.match(/(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})(\d{2})/)
        next if matched[1].to_i < 2022
        if basename.to_s =~ /added/
          "<li><a href=\"./jsons/#{basename}\">有志提供により追加 #{matched[1]}年#{matched[2]}月#{matched[3]}日 #{matched[4]}:#{matched[5]}分</a></li>"
        else
          "<li><a href=\"./jsons/#{basename}\">取得日 #{matched[1]}年#{matched[2]}月#{matched[3]}日 #{matched[4]}:#{matched[5]}分</a></li>"
        end
      end.compact.join("\n")
    end
  end
end

