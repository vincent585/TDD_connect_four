# frozen_string_literal: true

# Displayable methods
module Displayable
  def show_board
    puts '  1   2   3   4   5   6   7'
    cells.each do |row|
      print '|'
      row_output(row)
      puts
      puts '|---+---+---+---+---+---+---|'
    end
  end

  def row_output(row)
    row.each do |cell|
      print " #{cell}"
      print ' |'
    end
  end
end
