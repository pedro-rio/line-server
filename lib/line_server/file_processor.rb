module LineServer
  class FileProcessor
    @last_index = nil
    @batch_map = nil
    def self.process_data_file
      batch_size = 4000

      file = File.new('test_10GB.txt')
      batch_file = File.new('./data/batch_1.txt', 'w')
      @batch_map = { 1 => 'batch_1.txt' }

      line_counter = 1
      batch_counter = 1

      @last_index = 0

      file.each do |line|
        @last_index += 1
        if line_counter > batch_size
          line_counter = 1
          batch_counter += 1
          batch_file.close
          batch_file = File.open("./data/batch_#{batch_counter}.txt", 'w')
          @batch_map[batch_counter] = "batch_#{batch_counter}.txt"
        end
        batch_file.write(line)
        line_counter += 1
      end

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
