# frozen_string_literal: true

# Controller responsible for handling recent boards-related actions.
class RecentBoardsController < ApplicationController
  RECENTLY_CREATED_PER_PAGE = 10

  def index
    @boards = Board.order(created_at: :desc).limit(RECENTLY_CREATED_PER_PAGE)
  end
end
