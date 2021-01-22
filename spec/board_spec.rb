# frozen_string_literal: true
require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#game_over?' do
    context 'when there is a horizontal 4-in-a-row' do
      before do
        board.instance_variable_set(:@cells, Array.new(6) { Array.new(7) })
        board.cells[5] = ['x', 'x', 'x', 'x', ' ', ' ', ' ']
      end

      it 'is game over' do
        expect(board).to be_game_over
      end
    end
  end

  describe '#update_board' do
    # TODO
  end

  describe '#valid_move?' do
    # TODO
  end

  describe '#full?' do
    context 'when the board is new' do
      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is partially played' do
      before do
        board.instance_variable_set(:@cells, Array.new(6) { Array.new(7) })
        board.cells[5] = %w[x o x x o x o]
        board.cells[4] = %w[x o x x o x o]
      end

      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is full' do
      before do
        board.instance_variable_set(:@cells, Array.new(6) { Array.new(7, 'x') })
      end

      it 'is full' do
        expect(board).to be_full
      end
    end
  end
end
