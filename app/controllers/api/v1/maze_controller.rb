module Api::V1
  class MazeController < ApplicationController
    require_relative "mazeClass"

    def index
      params[:size] ? (size = params[:size].to_i) : (size = 6)

      @maze = MazeClass.new(size)
      @maze.mazeGen(@maze.maze)

      render json: @maze
    end
  end
end
