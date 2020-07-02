require 'pathname'
require 'time'
require_relative './aggregator'

class Generator
  class << self
    def execute
      File.read(File.expand_path('../templates/index.html', __FILE__))
          .gsub('<!--  snapshots here  -->', snapshot_links)
          .gsub('<!--  jsons here  -->', json_links)
          .gsub('FORMATTED_JSON', Aggregator.convert)
          .then do |replaced_content|
        File.open(File.expand_path('../index.html', __FILE__), 'w') do |writer|
          writer << replaced_content
        end
      end
    end


    private

    def snapshot_links
      Dir.glob(File.expand_path('../snapshots/*.html', __FILE__)).sort.reverse.map do |path|
        basename =  Pathname(path).basename
        matched = basename.to_s.match(/(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})(\d{2})/)
        "<li><a href=\"./snapshots/#{basename}\">取得日 #{matched[1]}年#{matched[1]}年#{matched[2]}月#{matched[3]}日 #{matched[4]}:#{matched[5]}分</a></li>"
      end.join("\n")
    end

    def json_links
      Dir.glob(File.expand_path('../jsons/*.json', __FILE__)).sort.reverse.map do |path|
        basename =  Pathname(path).basename
        matched = basename.to_s.match(/(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})(\d{2})/)
        "<li><a href=\"./jsons/#{basename}\">取得日 #{matched[1]}年#{matched[1]}年#{matched[2]}月#{matched[3]}日 #{matched[4]}:#{matched[5]}分</a></li>"
      end.join("\n")
    end
  end
end
