# frozen_string_literal: true

# Player object class
class Player
  attr_reader :number, :piece

  def initialize(number, piece)
    @number = number
    @piece = piece
  end
end
