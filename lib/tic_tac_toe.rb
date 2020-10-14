# frozen_string_literal: true

require_relative 'tic_tac_toe/cell'
require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/player'
require_relative 'tic_tac_toe/game'

puts 'Enter name of player 1: '
player1 = gets.chomp
puts 'Enter name of player 2: '
player2 = gets.chomp

player1 = Player.new(player1, 'O')
player2 = Player.new(player2, 'X')
game = Game.new([player1, player2])
game.play
