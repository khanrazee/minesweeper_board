# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the application.
# It inherits from ActiveRecord::Base and provides common functionalities
# shared across all models.
class BoardGeneratorService
  attr_accessor :board, :mine_coordinates, :minesweeper_board

  def initialize(board_params)
    @minesweeper_board = Board.new(board_params)
    @width = board_params[:width]&.to_i
    @height = board_params[:height]&.to_i
    @mines = board_params[:mines]&.to_i
    @board = Array.new(@height) { Array.new(@width, 0) }
    @mine_coordinates = []
  end

  def call
    return nil unless valid_board_params?

    place_mines
    populate_numbers
    minesweeper_board
  end

  private

  def place_mines
    while mine_coordinates.length < @mines
      x = rand(@width)
      y = rand(@height)
      unless board[y][x] == 9
        board[y][x] = 9
        mine_coordinates << [x, y]
      end
    end
    mine_coordinates
  end

  def populate_numbers
    mine_coordinates.each do |mine|
      x, y = mine
      neighbors = [
          [x - 1, y],
          [x - 1, y + 1],
          [x, y - 1],
          [x + 1, y - 1],
          [x + 1, y],
          [x + 1, y + 1],
          [x, y + 1],
          [x - 1, y - 1]
      ]
      neighbors.each do |n|
        nx, ny = n
        board[ny][nx] += 1 if width_covered?(nx) && height_covered?(ny) && board[ny][nx] != 9
      end
    end
    minesweeper_board.minesweeper_board = board
    minesweeper_board.save
  end

  def width_covered?(nx_cord)
    (0..@width - 1).cover?(nx_cord)
  end

  def height_covered?(ny_cord)
    (0..@height - 1).cover?(ny_cord)
  end

  def valid_board_params?
    minesweeper_board.valid?
  end
end
