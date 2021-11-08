require_relative '../lib/board.rb'
class Game
  
  attr_reader :players, :board, :current_player, :other_player
  
  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts
    puts "#{current_player.name} has randomly been selected as the first player"
    while true
      board.output_grid
      puts ""
      puts solicit_move
      x = get_move.to_i
      until board.set_cell(x, current_player.color)
        puts "Error, the column is full, try another one"
        puts ""
        puts solicit_move
        x = get_move.to_i
      end
      if board.game_over?
        puts game_over_message
        board.output_grid
        return
      else
        switch_players
      end
    end
  end

  def get_move
    move = gets.chomp
    until move.match?(/^[0-6]$/) do
      puts "Error, Please enter a correct number between 0 and 6"
      move = gets.chomp
    end
    move
  end
  
  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def solicit_move
    "#{current_player.name}: Enter a number between 0 and 6 to choose the column"
  end

  def game_over_message
    return "#{current_player.name} won!" if board.game_over? == :winner
    return "The game ended in a tie" if board.game_over? == :draw
  end
  
end
