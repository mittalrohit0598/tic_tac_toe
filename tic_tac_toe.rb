# frozen_string_literal: true

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
    get_cell(row, column).value = value
  end

  def get_cell(row, column)
    grid[row][column]
  end

  def game_over
    return 'winner' if winner?
    return 'draw' if draw?

    false
  end

  def winner?
    true
  end

  def draw?
    false
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
    while true
      board.print_grid
      puts "#{current_player.name}'s turn(Enter a number between 1 - 9): "
      x, y = get_move(gets.chomp)
      board.set_value(x, y, current_player.color)
      if board.game_over
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

  def get_move(human_move)
    human_move_to_coordinate(human_move)
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
    puts "#{current_player.name} WINS!" if board.game_over == 'winner'
    puts 'The game ends in a draw.' if board.game_over == 'draw'
  end
end

bob = Player.new('bob', 'x')
stan = Player.new('stan', 'o')
game = Game.new([bob, stan])
game.play
