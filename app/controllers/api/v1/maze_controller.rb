module Api::V1
  class MazeController < ApplicationController
    require_relative "mazeClass"

    def index
=begin
      if params[:size]
        size = params[:size].to_i
      else
        size = 5
      end
=end
      params[:size] ? (size = params[:size].to_i) : (size = 5)

      @maze = MazeClass.new(size)
      @maze.mazeGen(@maze.maze)

      render json: @maze
    end
  end
end
