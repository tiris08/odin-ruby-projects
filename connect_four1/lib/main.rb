require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
puts "Welcome to the game 'Connect Four'"
puts
puts "First player will be 'X': Plese enter your name"
player1 = Player.new(gets.chomp,"X")
puts "Second player will be 'O': Plese enter your name"
player2 = Player.new(gets.chomp,"O")
players = [player1, player2]
game = Game.new(players)
game.play

