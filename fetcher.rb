require 'net/http'
require 'uri'

# @abstract fetch html over http and save as a local file with timestamp
class Fetcher
  URL = 'http://www.cjh.com.cn/sqindex.html'

  class << self
    # @return [String] filepath
    def save
      url = URI.parse(Fetcher::URL)
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
      File.expand_path("../snapshots/#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.html", __FILE__).to_s.tap do |file_path|
        File.open(file_path, "w") do |writer|
          writer << res.body.gsub('assetscjsw/plugin/jquery-1.11.3.min.js', 'https://code.jquery.com/jquery-1.12.4.min.js')
        end
      end
    end
  end
end
