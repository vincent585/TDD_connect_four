# frozen_string_literal: true

describe Board do
  subject(:board) { described_class.new }

  describe '#game_over?' do
    context 'when there is a horizontal 4-in-a-row' do
      before do
        board.instance_variable_set(:@cells, Array.new(6) {Array.new(7)})
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
    # TODO
  end
end
