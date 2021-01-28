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
end
