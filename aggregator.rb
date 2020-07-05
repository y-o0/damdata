require 'json'

# @abstract concat jsons and convert them to a well-structured json
class Aggregator
  class << self
    # @return [String] json
    def convert
      Dir.glob(File.expand_path('../jsons/*.json', __FILE__)).sort.reverse[0..14 * 24].reduce(Hash.new) do |acc, cur|
        JSON.load(File.read(cur)).each do |r|
          acc[r['stnm']] ||= Hash.new
          acc[r['stnm']][r['tm']] = r
        end
        acc
      end.to_json
    end
  end
end
