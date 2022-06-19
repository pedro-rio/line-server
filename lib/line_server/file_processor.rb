module LineServer
  class FileProcessor
    @last_index = nil
    @batch_map = nil
    def self.process_data_file
      file_name = ENV['FILENAME']
      batch_size = ENV['PARTITION_SIZE'].to_i
      batch_directory = ENV['DATA_DIRECTORY']

      file = File.new(file_name)
      batch_file = File.new("#{batch_directory}/batch_0.txt", 'w')
      @batch_map = { 0 => 'batch_0.txt' }

      line_counter = 1
      batch_counter = 0

      @last_index = 0

      file.each do |line|
        @last_index += 1
        if line_counter > batch_size
          line_counter = 1
          batch_counter += 1
          batch_file.close
          batch_file = File.open("#{batch_directory}/batch_#{batch_counter}.txt", 'w')
          @batch_map[batch_counter] = "batch_#{batch_counter}.txt"
        end
        batch_file.write(line)
        line_counter += 1
      end

      @last_index-=1
      batch_file.close
    end

    def self.data_file_processed?
      !@last_index.nil?
      !@batch_map.nil?
    end

    def self.last_index
      @last_index
    end

    def self.batch_map
      @batch_map
    end
  end
end
