# frozen_string_literal: true

require_relative 'displayable'

# Connect 4 Board
class Board
  include Displayable
  attr_reader :cells

  def initialize
    @cells = Array.new(6) { Array.new(7, ' ') }
  end

  def full?
    cells.all? { |row| return true unless row.include?(' ') }
  end

  def valid_move?(move)
    return true if move.between?(1, 7) && column_not_full?(move)

    false
  end

  def column_not_full?(move)
    transposed = cells.transpose
    transposed[move - 1].include?(' ')
  end

  def update_board(player_move, player_marker)
    return nil unless valid_move?(player_move)

    selected_column = cells.transpose[player_move - 1]
    first_open_cell = selected_column.rindex(' ')
    @cells[first_open_cell][player_move - 1] = player_marker
  end

  def game_over?
    return true if horizontal_win?
    return true if vertical_win?
    return true if diagonal_win?

    false
  end

  def horizontal_win?
    result = false
    cells.each do |row|
      next unless row.count(' ') <= 3

      result = row.each_cons(4) { |a| return true if a.uniq.count == 1 }
    end
    result
  end

  def vertical_win?
    result = false
    cells.transpose.each do |col|
      next unless col.count(' ') <= 2

      result = col.each_cons(4) { |a| return true if a.uniq.count == 1 }
    end
    result
  end

  def diagonal_win?
    front_diagonals = find_front_diagonals.reject { |a| a.length < 4 }
    back_diagonals = find_back_diagonals.reject { |a| a.length < 4 }

    return true if front_diagonal_win?(front_diagonals)
    return true if back_diagonal_win?(back_diagonals)

    false
  end

  def find_front_diagonals
    padding = cells.size - 1
    padded_board = []

    cells.each do |row|
      inverse_padding = cells.size - padding
      padded_board << ([nil] * inverse_padding) + row + ([nil] * padding)
      padding -= 1
    end

    padded_board.transpose.map(&:compact)
  end

  def find_back_diagonals
    padding = cells.size - 1
    padded_board = []

    cells.each do |row|
      inverse_padding = cells.size - padding
      padded_board << ([nil] * padding) + row + ([nil] * inverse_padding)
      padding -= 1
    end

    padded_board.transpose.map(&:compact)
  end

  def front_diagonal_win?(front_diagonals)
    result = false

    front_diagonals.each do |line|
      next unless line.count(' ') <= 2

      result = line.each_cons(4) { |a| return true if a.uniq.count == 1 }
    end
    result
  end

  def back_diagonal_win?(back_diagonals)
    result = false

    back_diagonals.each do |line|
      next unless line.count(' ') <= 2

      result = line.each_cons(4) { |a| return true if a.uniq.count == 1 }
    end
    result
  end
end
