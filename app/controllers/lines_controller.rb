require 'line_server/file_processor'
require 'line_server/repository'

class LinesController < ApplicationController
  def initialize
    @max_lines = LineServer::FileProcessor.last_index
  end

  def index
    return head :bad_request if invalid_index_value(params['index'])

    index = params['index'].to_i
    return head :payload_too_large if index > @max_lines

    @line = LineServer::Repository.new.find_by_index(index)
  end

  private
  def invalid_index_value(index)
    index.to_s.match(/^\d+\d*$/).nil?
  end
end
