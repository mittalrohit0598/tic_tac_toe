# frozen_string_literal: true

require './lib/tic_tac_toe/game'

describe Game do
  describe '#initialize' do
    it 'when arguments are absent' do
      expect { Game.new }.to raise_error ArgumentError
    end
    it 'when arguments are present' do
      expect { Game.new(['player1, plaer2']) }.to_not raise_error
    end
  end
  describe '#switch_players' do
    it 'swaps current_player and other_player' do
      game = Game.new(%w[player1 player2])
      players = game.current_player, game.other_player
      game.send(:switch_players)
      expect([game.other_player, game.current_player]).to eq(players)
    end
  end
end
