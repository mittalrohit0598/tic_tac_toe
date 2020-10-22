# frozen_string_literal: true

require './lib/tic_tac_toe/game'

describe Game do
  let(:game) { Game.new(%w[player1 player2]) }
  describe '#initialize' do
    it 'when arguments are absent' do
      expect { Game.new }.to raise_error ArgumentError
    end
    it 'when arguments are present' do
      expect { game }.to_not raise_error
    end
  end
  describe '#switch_players' do
    it 'swaps current_player and other_player' do
      players = game.current_player, game.other_player
      game.send(:switch_players)
      expect([game.other_player, game.current_player]).to eq(players)
    end
  end
  describe '#move' do
    it 'returns coordinates for the respective numbers' do
      allow(game).to receive(:solicit_move)
      allow(game).to receive(:gets).and_return('3')
      move = game.send(:move)
      expect(move).to eq([0, 2])
    end
    it 'run loop untill a valid move is entered' do
      allow(game).to receive(:solicit_move)
      allow(game).to receive(:gets).and_return('10')
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('4')
      move = game.send(:move)
      expect(move).to eq([1, 0])
    end
  end
  describe '#invalid_move?' do
    describe 'returns false when move is between 1 and 9' do
      it 'returns false when move is 1' do
        expect(game.send(:invalid_move?, 1)).to eq(false)
      end
      it 'returns false when move is 9' do
        expect(game.send(:invalid_move?, 1)).to eq(false)
      end
    end
    it 'returns true when move is not between 1 and 9' do
      expect(game.send(:invalid_move?, 10)).to eq(true)
    end
  end
end
