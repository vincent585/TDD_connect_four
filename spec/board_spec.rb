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

      xit 'is game over' do
        expect(board).to be_game_over
      end
    end
  end

  describe '#update_board' do
    context 'when the board is new' do
      it 'updates the board' do
        player_move = '3'
        player_marker = 'x'
        board.update_board(player_move, player_marker)
        updated_cell = board.cells[5][2]
        expect(updated_cell).to eq('x')
      end
    end
  end

  describe '#valid_move?' do
    context 'when the user inputs a valid move' do
      it 'is a valid move' do
        player_move = board.valid_move?('1')
        expect(player_move).to be true
      end
    end

    context 'when choosing a column that is full' do
      before do
        6.times { |i| board.cells[i][0] = 'x' }
      end
      it 'is not a valid move' do
        player_move = board.valid_move?('1')
        expect(player_move).to be false
      end
    end

    context 'when choosing a cell not on the board' do
      it 'is not a valid move' do
        player_move = board.valid_move?('10')
        expect(player_move).to be false
      end
    end

    context 'when choosing a column that is partially full' do
      before do
        4.times { |i| board.cells[i][0] = 'x' }
      end
      it 'is a valid move' do
        player_move = board.valid_move?('1')
        expect(player_move).to be true
      end
    end
  end

  describe '#full?' do
    context 'when the board is new' do
      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is partially played' do
      before do
        board.instance_variable_set(:@cells, Array.new(6) { Array.new(7, ' ') })
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
