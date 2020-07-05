class Extractor
  class << self
    def save(snapshot_path)
      html = File.read(snapshot_path)
      matched = html.match(/var sssq = (.+?);/)
      unless matched[1].nil?
        file_path = snapshot_path.gsub('snapshots', 'jsons').gsub('.html', '.json')
        File.open(file_path, "w") do |writer|
          writer << matched[1]
        end
      end
    end
  end
end
