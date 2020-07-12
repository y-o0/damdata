require 'csv'
require 'json'

def csv2json fname = '../../settings/pointinfo.csv', encoding = 'UTF-8', primary_key = 'stnm', **csv_options
  CSV.read(File.expand_path(fname, __FILE__), headers: csv_options[:headers] || true, encoding: encoding).to_h do |row|
    [row[primary_key], (row.headers - [primary_key]).to_h { |r| [r, row[r].to_s] }]
  end.tap do |r|
    File.open(File.expand_path(fname, __FILE__).to_s.gsub(/.csv$/, '.json'), 'w') do |writer|
      writer << r.to_json
    end
  end
end

csv2json
