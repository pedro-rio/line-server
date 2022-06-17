require 'line_server/file_processor'
require 'line_server/repository'

class LinesController < ApplicationController
  def initialize
    @max_lines = LineServer::FileProcessor.last_index
  end

  def index
    index = params['index'].to_i
    return head :payload_too_large if index > @max_lines

    @line = LineServer::Repository.new.find_by_index(index)

    render json: { line: @line }, status: :ok
  end

  private
  def check_index_value(index)
    #check index value
  end
end
