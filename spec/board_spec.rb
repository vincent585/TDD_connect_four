# frozen_string_literal: true

require './lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  describe '#game_over?' do
    context 'when there is a horizontal 4-in-a-row' do
      before do
        board.cells[5] = %w[x x x x o o o]
      end

      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'when there is a vertical 4-in-a-row' do
      before do
        4.times { |i| board.cells[i][0] = 'x' }
      end

      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'when there is a front-facing diagonal 4-in-a-row' do
      before do
        board.instance_variable_set(
          :@cells,
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            %w[o x o o x x o],
            %w[x x o o x x o],
            %w[x o x x o o o],
            %w[o x o x o o x]
          ]
        )
      end

      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'when there is a back-facing diagonal 4-in-a-row' do
      before do
        board.instance_variable_set(
          :@cells,
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            %w[o x o x x x o],
            %w[x x o o x x o],
            %w[x o x x o x o],
            %w[o x o x o o x]
          ]
        )
      end

      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'when the board is new' do
      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end

    context 'when the board is partially played' do
      before do
        board.instance_variable_set(
          :@cells,
          [
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' '],
            %w[x x o o x x o],
            %w[x o x x o o o],
            %w[o x o x o o x]
          ]
        )
      end

      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end
  end

  describe '#update_board' do
    context 'when the board is new' do
      it 'updates the board' do
        player_move = 3
        player_marker = 'x'
        board.update_board(player_move, player_marker)
        updated_cell = board.cells[5][2]
        expect(updated_cell).to eq('x')
      end
    end

    context 'when the column is partially full' do
      before do
        board.cells[5][2] = 'x'
      end

      it 'updates the next available cell' do
        player_move = 3
        player_marker = 'x'
        board.update_board(player_move, player_marker)
        updated_cell = board.cells[4][2]
        expect(updated_cell).to eq('x')
      end
    end

    context 'when the column is full' do
      before do
        6.times { |i| board.cells[i][0] = 'x' }
      end

      it 'does not update the board' do
        player_move = 1
        player_marker = 'x'
        result = board.update_board(player_move, player_marker)
        expect(result).to be_nil
      end
    end

    context 'when the move is not on the board' do
      it 'does not update the board' do
        player_move = 10
        player_marker = 'x'
        result = board.update_board(player_move, player_marker)
        expect(result).to be_nil
      end
    end
  end

  describe '#valid_move?' do
    context 'when the user inputs a valid move' do
      it 'is a valid move' do
        player_move = board.valid_move?(1)
        expect(player_move).to be true
      end
    end

    context 'when choosing a column that is full' do
      before do
        6.times { |i| board.cells[i][0] = 'x' }
      end
      it 'is not a valid move' do
        player_move = board.valid_move?(1)
        expect(player_move).to be false
      end
    end

    context 'when choosing a cell not on the board' do
      it 'is not a valid move' do
        player_move = board.valid_move?(10)
        expect(player_move).to be false
      end
    end

    context 'when choosing a column that is partially full' do
      before do
        4.times { |i| board.cells[i][0] = 'x' }
      end
      it 'is a valid move' do
        player_move = board.valid_move?(1)
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

# rubocop:enable Metrics/BlockLength
