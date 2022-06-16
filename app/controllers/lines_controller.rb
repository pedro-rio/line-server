require 'line_server/file_processor'

class LinesController < ApplicationController
  def initialize
    @max_lines = LineServer::FileProcessor.last_index
    @batch_map = LineServer::FileProcessor.batch_map
    @batch_size = 4000.to_f
  end

  def index
    index = params['index'].to_i
    return head :payload_too_large if index > @max_lines

    partition = get_partition(index)
    partition_index = index%@batch_size

    file = File.readlines("./data/#{partition}")
    @line = file[partition_index]

    render json: { line: @line }, status: :ok
  end

  private
  def check_index_value(index)
    #check index value
  end

  def get_partition(index)
    return @batch_map[1] if index < @batch_size
    partition_number = (index/@batch_size).ceil
    @batch_map[partition_number]
  end

end
