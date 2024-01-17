# frozen_string_literal: true

# Model representing a board in the application.
class Board < ApplicationRecord
  validates :width, :height, :mines, presence: true
  validate :mines_validation

  private

  def mines_validation
    max_allowed_mines = (0.15 * width.to_i * height.to_i).ceil

    return unless mines.to_i.negative? || mines.to_i > max_allowed_mines

    errors.add(:mines, "should be between 1 and #{max_allowed_mines}")
  end
end
