# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'

# Game object class
class Game
  include Displayable
  attr_reader :board, :player_one, :player_two, :current_player

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @current_player = nil
  end

  def play_game
    instructions
    set_player_markers
    set_current_player
    player_turns
  end

  def player_turns
    until board.full?
      board.show_board
      player_turn
      return display_winner_message if board.game_over?

      set_current_player
    end
  end

  def player_turn
    player_turn_prompt
    board.update_board(select_column, current_player.piece)
  end

  def select_column
    gets.chomp.to_i
  end

  def set_player_markers
    player_marker_prompt
    set_player_one
    puts 'Great, now Player 2 choose a different marker!'
    set_player_two
  end

  def set_current_player
    return @current_player = [player_one, player_two].sample if current_player.nil?

    @current_player = current_player == player_one ? player_two : player_one
  end

  def select_marker
    gets.chomp.to_i
  end

  def valid_marker?(marker)
    return AVAILABLE_MARKERS[marker - 1] if marker.between?(1, 4)
  end

  def set_player_one
    loop do
      marker = valid_marker?(select_marker)
      if marker
        @player_one = Player.new(1, marker)
        break
      else
        puts 'Please choose a valid marker!'
      end
    end
  end

  def set_player_two
    loop do
      marker = valid_marker?(select_marker)
      if marker && marker != player_one.piece
        @player_two = Player.new(2, marker)
        break
      else
        puts 'Please choose a valid marker!'
      end
    end
  end
end

x = Game.new
x.play_game
