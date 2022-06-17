module LineServer
  class Repository
    def initialize
      @batch_map = LineServer::FileProcessor.batch_map
      @batch_size = 4000.to_f
    end

    def find_by_index(index)
      partition = get_partition(index)
      partition_index = get_partition_index(index)
      read_line_from_partition(partition, partition_index)
    end

    private
    def get_partition(index)
      partition_number = (index/@batch_size).ceil
      partition_number +=1 if index%@batch_size == 0
      @batch_map[partition_number]
    end

    def get_partition_index(index)
      index%@batch_size
    end

    def read_line_from_partition(partition, partition_index)
      index = 0
      file = File.new("./data/#{partition}")
      file.each do |line|
        return line if index == partition_index
        index+=1
      end
      file.close
    end

  end
end
