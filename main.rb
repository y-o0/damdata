require_relative './scripts/fetcher'
require_relative './scripts/extractor'
require_relative './scripts/generator'

file_path = Fetcher.save
Extractor.save(file_path)
Generator.execute
