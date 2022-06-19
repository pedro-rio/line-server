module LineServer
  class Repository
    def initialize
      @batch_map = LineServer::FileProcessor.batch_map
      @batch_size = ENV['PARTITION_SIZE'].to_i
      @batch_directory = ENV['DATA_DIRECTORY']
    end

    def find_by_index(index)
      partition = get_partition(index)
      partition_index = get_partition_index(index)
      read_line_from_partition(partition, partition_index)
    end

    private
    def get_partition(index)
      partition_number = index/@batch_size
      @batch_map[partition_number]
    end

    def get_partition_index(index)
      index%@batch_size
    end

    def read_line_from_partition(partition, partition_index)
      index = 0
      file = File.new("#{@batch_directory}/#{partition}")
      file.each do |line|
        return line if index == partition_index
        index+=1
      end
      file.close
    end

  end
end
