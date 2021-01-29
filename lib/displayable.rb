# frozen_string_literal: true

# Displayable methods
module Displayable
  AVAILABLE_MARKERS = ["\u2600", "\u2605", "\u2665", "\u2666"].freeze

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

  def display_winner_message
    puts "#{current_player} wins!"
  end

  def player_marker_prompt
    puts 'Please choose one of the following markers: '
    show_available_markers
  end

  def instructions
    puts <<-HEREDOC

          Let's play: Connect Four!

          The rules are as follows:

          Players will alternate dropping markers into the columns.
          The first player to get 4 of their markers consecutively
          in a row, column, or diagonal will win the game.

          If neither player has 4 consecutive markers and the board is full,
          the game will result in a tie!

          Lets begin!

    HEREDOC
  end

  def show_available_markers
    AVAILABLE_MARKERS.each_with_index { |marker, i| puts "#{i + 1}: #{marker}" }
  end
end
