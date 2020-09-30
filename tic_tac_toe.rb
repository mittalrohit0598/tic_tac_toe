# frozen_string_literal: true

# class Array
class Array
  def all_same?
    all? { |n| n == self[0] }
  end

  def none_empty?
    all? { |n| n != '_' }
  end
end

# class Cell
class Cell
  attr_accessor :value
  def initialize(value = '_')
    @value = value
  end
end

# class Player
class Player
  attr_reader :name, :color
  def initialize(name, color)
    @name = name
    @color = color
  end
end

# class Board
class Board
  attr_reader :grid
  def initialize(grid = default_grid)
    @grid = grid
  end

  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end

  def set_value(row, column, value)
    grid[row][column].value = value
  end

  def winner?
    horizontal_check?(grid) || vertical_check? || diagonal_up_check? || diagonal_down_check?
  end

  def horizontal_check?(grid)
    grid.each do |arr|
      arr[0...arr.length - 3 + 1].each_index do |i|
        return true if arr[i, 3].map(&:value).all_same? && arr[i].value != '_'
      end
    end
    false
  end

  def vertical_check?
    horizontal_check?(grid.transpose)
  end

  def diagonal_down_check?
    grid[0...grid.length - 2].each_with_index do |arr, i|
      arr.each_index do |j|
        diagonal_array = []
        3.times do |k|
          diagonal_array << grid[i + k][j + k]&.value
        end
        return true if diagonal_array.all_same? && diagonal_array[i] != '_'
      end
    end
    false
  end

  def diagonal_up_check?
    (2...grid.length).reverse_each do |i|
      grid[i].each_index do |j|
        diagonal_array = []
        3.times do |k|
          diagonal_array << grid[i - k][j + k]&.value
        end
        return true if diagonal_array.all_same? && diagonal_array[i] != '_'
      end
    end
    false
  end

  def draw?
    grid.flatten.map(&:value).none_empty?
  end

  def print_grid
    grid.each do |arr|
      arr.each do |cell|
        print cell.value + ' '
      end
      puts
    end
  end
end

# class Game
class Game
  attr_accessor :players, :board, :current_player, :other_player
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts "#{current_player.name} is selected as the first player!"
    loop do
      solicit_move
      x, y = get_move
      board.set_value(x, y, current_player.color)
      if board.winner? || board.draw?
        game_over_message
        board.print_grid
        return
      end
      switch_players
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def get_move(human_move = gets.chomp)
    loop do
      return human_move_to_coordinate(human_move) if invalid_move?(human_move)

      puts 'Invalid move'
      solicit_move
      human_move = gets.chomp
    end
  end

  def human_move_to_coordinate(human_move)
    mapping = {
      '1' => [0, 0],
      '2' => [0, 1],
      '3' => [0, 2],
      '4' => [1, 0],
      '5' => [1, 1],
      '6' => [1, 2],
      '7' => [2, 0],
      '8' => [2, 1],
      '9' => [2, 2]
    }
    mapping[human_move]
  end

  def game_over_message
    puts "#{current_player.name} WINS!" if board.winner?
    puts 'The game ends in a draw.' if board.draw?
  end

  def solicit_move
    board.print_grid
    puts "#{current_player.name}'s turn(Enter a number between 1 - 9): "
  end

  def invalid_move?(human_move)
    if (1..9).include?(human_move.to_i)
      x, y = human_move_to_coordinate(human_move)
      return true if board.grid[x][y].value == '_'
    end
    false
  end
end

bob = Player.new('bob', 'x')
stan = Player.new('stan', 'o')
game = Game.new([bob, stan])
game.play
