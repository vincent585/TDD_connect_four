# frozen_string_literal: true

require './lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#set_player_markers' do
    context 'when a player chooses a valid marker' do
      before do
        valid_input = '1'
        allow(game).to receive(:puts).exactly(5).times
        allow(game).to receive(:select_marker).and_return(valid_input)
      end

      it 'sets player one marker' do
        game.set_player_markers
        player_one_marker = game.player_one.piece
        expect(player_one_marker).to eq("\u2600")
      end
    end
  end
end
