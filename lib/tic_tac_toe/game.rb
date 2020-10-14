# frozen_string_literal: true

# class Game
class Game
  attr_accessor :players, :board, :current_player, :other_player
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts "#{current_player.name} is selected at random to make the first move!"
    loop do
      x, y = move
      board.set_value(x, y, current_player.color)
      if board.winner? || board.draw?
        game_over_message
        return
      end
      switch_players
    end
  end

  private

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def move
    loop do
      solicit_move
      human_move = gets.chomp
      return human_move_to_coordinate(human_move) unless invalid_move?(human_move)

      puts 'Invalid move'
    end
  end

  def human_move_to_coordinate(human_move)
    mapping = []
    3.times do |i|
      3.times do |j|
        mapping << [i, j]
      end
    end

    mapping[human_move.to_i - 1]
  end

  def game_over_message
    puts "#{current_player.name} WINS!" if board.winner?
    puts 'The game ends in a draw.' if board.draw?
    board.print_grid
  end

  def solicit_move
    board.print_grid
    puts "#{current_player.name}'s turn(Enter a number between 1 - 9): "
  end

  def invalid_move?(human_move)
    if (1..9).include?(human_move.to_i)
      x, y = human_move_to_coordinate(human_move)
      return false if board.grid[x][y].value == '_'
    end
    true
  end
end
