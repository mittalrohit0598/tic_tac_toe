# frozen_string_literal: true

require './lib/tic_tac_toe/board'
require './lib/tic_tac_toe/cell'

describe Board do
  let(:x) { Cell.new('X') }
  let(:y) { Cell.new('O') }
  let(:empty) { Cell.new('_') }

  describe '#initialize' do
    it 'when argument is given' do
      expect { Board.new(grid: 'grid') }.to_not raise_error
    end
    it 'when argument is not given' do
      expect { Board.new }.to_not raise_error
    end
  end
  describe '#default_board' do
    it 'sets the grid with three rows by default' do
      board = Board.new
      expect(board.grid.size).to eq(3)
    end
    it 'creates the rows with three things by default' do
      board = Board.new
      board.grid.each do |row|
        expect(row.size).to eq(3)
      end
    end
  end
  describe '#grid' do
    it 'returns grid' do
      board = Board.new('abc')
      expect(board.grid).to eq('abc')
    end
  end
  describe '#get_value' do
    it 'returns value from given (x, y) co-ordinate' do
      board = Board.new([['', '', ''], ['', '', 'X'], ['', '', '']])
      expect(board.get_value(1, 2)).to eq('X')
    end
  end
  describe '#set_value' do
    it 'set the given value on given (x, y) co-ordinate' do
      board = Board.new([[Cell.new('abc'), '', ''], ['', '', 'X'], ['', '', '']])
      board.set_value(0, 0,'xyz')
      expect(board.get_value(0, 0).value).to eq('xyz')
    end
  end
  describe '#winner?' do
    it 'returns true when horizontal_check? is true' do
      board = Board.new
      allow(board).to receive_messages(horizontal_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when vertical_check? is true' do
      board = Board.new
      allow(board).to receive_messages(vertical_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when diagonal_up_check? is true' do
      board = Board.new
      allow(board).to receive_messages(diagonal_up_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when diagonal_down_check? is true' do
      board = Board.new
      allow(board).to receive_messages(diagonal_up_check?: true)
      expect(board.winner?).to eq(true)
    end
    it 'returns true when first row contains the same things and not "_"' do
      board = Board.new([[x, x, x], [y, y, empty], [empty, empty, empty]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when second row contains the same things and not "_"' do
      board = Board.new([[x, x, empty], [y, y, y], [empty, empty, empty]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when third row contains the same things and not "_"' do
      board = Board.new([[empty, empty, empty], [y, y, empty], [x, x, x]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when first column contains the same things and not "_"' do
      board = Board.new([[x, y, empty], [x, y, empty], [x, empty, empty]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when second column contains the same things and not "_"' do
      board = Board.new([[x, y, empty], [x, y, empty], [empty, y, empty]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when third column contains the same things and not "_"' do
      board = Board.new([[empty, y, x], [empty, y, x], [empty, empty, x]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when top_left to bottom_right contains the same things and not "_"' do
      board = Board.new([[x, y, x], [y, x, y], [empty, empty, x]])
      expect(board.winner?).to eq(true)
    end
    it 'returns true when top_right to bottom_left contains the same things and not "_"' do
      board = Board.new([[x, y, x], [y, x, y], [x, empty, empty]])
      expect(board.winner?).to eq(true)
    end
  end
  describe '#draw?' do
    it 'returns true when all cells are not "_"' do
      board = Board.new([[y, x, y], [x, x, y], [y, y, x]])
      expect(board.draw?).to eq(true)
    end
  end
end
