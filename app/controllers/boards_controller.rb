# frozen_string_literal: true

# The BoardsController handles interactions related to boards.
# It is responsible for managing and displaying boards.
class BoardsController < ApplicationController
  DEFAULT_PER_PAGE = 1

  before_action :set_board, only: [:show]

  def index
    @boards = Board.page(params[:page]).per(DEFAULT_PER_PAGE)
  end

  def show; end

  def new
    @board = Board.new
  end

  def create
    @board = BoardGeneratorService.new(board_params).call

    if @board
      redirect_to @board, notice: 'Board was successfully generated.'
    else
      flash.now[:alert] = 'Failed to generate the board. Please check your input.'
      render :new
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :mines)
  end
end
