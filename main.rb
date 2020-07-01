require_relative './fetcher'
require_relative './extractor'
require_relative './generator'

file_path = Fetcher.save
sleep 1
Extractor.save(file_path)
sleep 1
Generator.execute
