# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#set_player_one' do
    context 'when a player chooses a valid marker' do
      before do
        valid_input = 1
        allow(game).to receive(:puts).exactly(5).times
        allow(game).to receive(:select_marker).and_return(valid_input)
      end

      it 'sets player one marker' do
        game.set_player_one
        player_one_marker = game.player_one.piece
        expect(player_one_marker).to eq("\u2600")
      end
    end

    context 'when a player chooses an invalid marker, then a valid marker' do
      before do
        invalid_input = 5
        valid_input = 1
        allow(game).to receive(:puts).exactly(5).times
        allow(game).to receive(:select_marker).and_return(invalid_input, valid_input)
      end

      it 'displays the error message once and ends the loop' do
        expect(game).to receive(:puts).with('Please choose a valid marker!')
        game.set_player_one
      end

      it 'sets player one marker' do
        game.set_player_one
        player_one_marker = game.player_one.piece
        expect(player_one_marker).to eq("\u2600")
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
