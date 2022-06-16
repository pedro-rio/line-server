require 'line_server/file_processor'

puts "Processing Data File"
LineServer::FileProcessor.process_data_file
unless LineServer::FileProcessor.data_file_processed?
  Rails.logger.error("Exiting, failed to read data from file")
  raise "Exiting, failed to read data from file"
end
puts "Processed Data File"
