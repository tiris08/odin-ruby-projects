class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Board
  @@arr = [1,2,3,4,5,6,7,8,9]
  @@winning_combos = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def display_board 
    puts "#{@@arr[0]} | #{@@arr[1]} | #{@@arr[2]}"
    puts "----------"
    puts "#{@@arr[3]} | #{@@arr[4]} | #{@@arr[5]}"
    puts "----------"
    puts "#{@@arr[6]} | #{@@arr[7]} | #{@@arr[8]}"
  end

  def check_win(symb)
    if (@@arr[0] == symb) && (@@arr[1] == symb) && (@@arr[2] == symb)
      return 'win'
    elsif (@@arr[0] == symb) && (@@arr[3] == symb) && (@@arr[6] == symb)
      return 'win'
    elsif (@@arr[0] == symb) && (@@arr[4] == symb) && (@@arr[8] == symb)
      return 'win'
    elsif (@@arr[1] == symb) && (@@arr[4] == symb) && (@@arr[7] == symb)
      return 'win'
    elsif (@@arr[2] == symb) && (@@arr[5] == symb) && (@@arr[8] == symb)
      return 'win'
    elsif (@@arr[3] == symb) && (@@arr[4] == symb) && (@@arr[5] == symb)
      return 'win'
    elsif (@@arr[6] == symb) && (@@arr[7] == symb) && (@@arr[8] == symb)
      return 'win'
    elsif (@@arr[2] == symb) && (@@arr[4] == symb) && (@@arr[6] == symb)
      return 'win'
    else 
      return
    end
  end

  def play 
    puts "You're first player so you're gonna be 'X' whats your name?"
    playerX = Player.new(gets.chomp)
    puts "----------------------------------------------------"
    puts
    puts "Welcome to the game #{playerX.name}"
    puts
    puts "----------------------------------------------------"
    puts "You're second player so you're gonna be 'O' whats your name?"
    playerO = Player.new(gets.chomp)
    puts "----------------------------------------------------"
    puts
    puts "Welcome to the game #{playerO.name}"
    puts
    puts "----------------------------------------------------"
    chosing(playerX.name, playerO.name)
  end

  def update(pla)
    @@arr[@number - 1] = pla
  end

  def chosing(plax, plao)
    somebody_won = false
    display_board
    (1..9).each do |i|
      if i.odd?
        puts "----------------------------------------------------" 
        puts "#{plax} choose where you want to put your X"
        @number = gets.chomp.to_i
        until  @number > 0 && @number < 10
          puts "Type a digit from 1 to 9"
          @number = gets.chomp.to_i
        end
        self.update("X")
        display_board
        if self.check_win("X") == 'win'
          puts "========================="
          puts "Congrats #{plax} you won the game"
          puts "========================="
          somebody_won = true
          break
        end
      else
        puts "----------------------------------------------------"
        puts "#{plao} choose where you want to put your O"
        @number = gets.chomp.to_i
        until  @number > 0 && @number < 10
          puts "Type a digit from 1 to 9"
          @number = gets.chomp.to_i
        end
        self.update("O")
        display_board
        if self.check_win("O") == 'win'
          puts "========================="
          puts "Congrats #{plao} you won the game"
          puts "========================="
          somebody_won = true
          break
        end
      end
    end
    if somebody_won
      puts "========================="
      puts "It's a draw"
      puts "========================="
    end
  end
end


game = Board.new
game.play