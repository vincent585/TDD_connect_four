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
end

x = Board.new
x.show_board
