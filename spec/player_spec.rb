# frozen_string_literal: true

require './lib/tic_tac_toe/player'

describe Player do
  describe '#initialize' do
    describe 'when initialized without name or color raises an exception' do
      it 'when initialized without values' do
        expect { Player.new }.to raise_error(ArgumentError)
      end
      it 'when initialized with one value' do
        expect { Player.new('abc') }.to raise_error(ArgumentError)
      end
    end
    it 'when initialized with correct arguments' do
      expect { Player.new('abc', 'X') }.to_not raise_error
    end
  end
  describe '#color' do
    it 'returns the color' do
      player = Player.new('abc', 'X')
      expect(player.color).to eql('X')
    end
    it 'returns the playes\'s name' do
      player = Player.new('abc', 'X')
      expect(player.name).to eql('abc')
    end
  end
end
