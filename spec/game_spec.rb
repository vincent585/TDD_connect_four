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

      it 'sets the player marker' do
        game.set_player_one
        player_one_marker = game.player_one.piece
        expect(player_one_marker).to eq("\u2600")
      end
    end
  end

  describe '#set_player_two' do
    context 'when a player chooses a valid marker' do
      before do
        game.instance_variable_set(:@player_one, Player.new(1, "\u2605"))
        valid_input = 1
        allow(game).to receive(:puts).exactly(5).times
        allow(game).to receive(:select_marker).and_return(valid_input)
      end

      it 'ends the loop and does not display the error message' do
        expect(game).not_to receive(:puts).with('Please choose a valid marker!')
        game.set_player_two
      end

      it 'sets the player marker' do
        game.set_player_two
        player_two_marker = game.player_two.piece
        expect(player_two_marker).to eq("\u2600")
      end
    end

    context 'when a player chooses an invalid marker, then a valid marker' do
      before do
        game.instance_variable_set(:@player_one, Player.new(1, "\u2605"))
        invalid_input = 2
        valid_input = 1
        allow(game).to receive(:puts).exactly(5).times
        allow(game).to receive(:select_marker).and_return(invalid_input, valid_input)
      end

      it 'displays the error message once then ends the loop' do
        expect(game).to receive(:puts).with('Please choose a valid marker!')
        game.set_player_two
      end

      it 'sets the player marker' do
        game.set_player_two
        player_two_marker = game.player_two.piece
        expect(player_two_marker).to eq("\u2600")
      end
    end
  end

  describe '#set_current_player' do
    context 'when the current player has not been set' do
      before do
        game.instance_variable_set(:@player_one, Player.new(1, "\u2600"))
        game.instance_variable_set(:@player_two, Player.new(2, "\u2605"))
      end

      it 'sets a random player' do
        game.set_current_player
        current_player = game.current_player
        expect(current_player).not_to be_nil
      end
    end

    context 'when the current player is player one' do
      before do
        game.instance_variable_set(:@player_one, Player.new(1, "\u2600"))
        game.instance_variable_set(:@player_two, Player.new(2, "\u2605"))
        game.instance_variable_set(:@current_player, game.player_one)
      end

      it 'sets the current player to player two' do
        game.set_current_player
        current_player = game.current_player
        expect(current_player).to eq(game.player_two)
      end
    end

    context 'when the current player is two' do
      before do
        game.instance_variable_set(:@player_one, Player.new(1, "\u2600"))
        game.instance_variable_set(:@player_two, Player.new(2, "\u2605"))
        game.instance_variable_set(:@current_player, game.player_two)
      end

      it 'sets the current player to player one' do
        game.set_current_player
        current_player = game.current_player
        expect(current_player).to eq(game.player_one)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
