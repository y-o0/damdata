require 'json'
require 'date'

# @abstract concat jsons and convert them to a well-structured json
class Aggregator
  class << self
    # @return [String] json
    def convert
      Dir.glob(File.expand_path("../../jsons/#{Date.today.year}*.json", __FILE__)).sort.reverse[0..30 * 24].reduce(Hash.new) do |acc, cur|
        JSON.load(File.read(cur)).each do |r|
          acc[r['stnm']] ||= Hash.new
          acc[r['stnm']][r['tm']] = { z: r['z'].to_f, q: r['q'].to_i, oq: r['oq'].to_i }
        end
        acc
      end.to_json
    end
  end
end

