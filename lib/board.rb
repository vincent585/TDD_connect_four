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
    return true if move.match?(/^[1-7]$/) && column_not_full?(move)

    false
  end

  def column_not_full?(move)
    transposed = cells.transpose
    transposed[move.to_i - 1].include?(' ')
  end

  def update_board(player_move, player_marker)
    return nil unless valid_move?(player_move)

    selected_column = cells.transpose[player_move.to_i - 1]
    first_open_cell = selected_column.rindex(' ')
    @cells[first_open_cell][player_move.to_i - 1] = player_marker
  end

  def game_over?
    return true if horizontal_win?
    return true if vertical_win?

    false
  end

  def horizontal_win?
    result = false
    cells.each do |row|
      next unless row.count(' ') <= 3

      result = row.each_cons(4) { |a| return true if a.count('x') == 4 || a.count('o') == 4 }
    end
    result
  end

  def vertical_win?
    result = false
    cells.transpose.each do |col|
      next unless col.count(' ') <= 2

      result = col.each_cons(4) { |a| return true if a.count('x') == 4 || a.count('o') == 4 }
    end
    result
  end

  def diagonal_win?
    # TODO
  end
end
