require "yaml"
require_relative "player.rb"

class Hangman
 attr_accessor :secretword, :holder, :tries
  def initialize
    @secretword = self.randomize_word_to_guess()
    @holder = self.create_holder_for_secretword(@secretword)
    @tries = 6
  end

  def randomize_word_to_guess()
    words_library = ''
    until words_library.length >=7 && words_library.length <=14 do
      words_library = File.readlines("5desk.txt").sample
    end
    words_library.downcase.chomp.split('')
  end
  
  def create_holder_for_secretword(secretword)
    Array.new(secretword.length, " _")
  end

  def welcome()
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome to the game the Hangman"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "What is your name?"
    name = gets.chomp
    puts "Nice to see you #{name.capitalize}"
    puts "if you want to load the game plese press Y/y if no press N/n"
    # puts "Your word to guess is #{secret} with length of #{secret.length}"
    answer = gets.chomp
    if answer.downcase == "y"
      self.load_game
      puts "Cool, from the last time you still got #{@tries} tries"
      puts "And here is a placeholder for the secret word #{@holder.join()}"
      puts "Let's continue to play, pick your letter."
    else
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Cool, here is placeholder for your word #{@holder.join()}"
      puts "And don't forget you have only 6 tries"
      puts "type in your guess letter or word to strat a game"
    end
  end

  def save_game?()
    puts "If you want to save the game just press Y/y"
    answer = gets.chomp
    if answer.downcase == "y"
      save_game()
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Game saved"
      puts "Let's continue to play, pick your letter."
    else 
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Let's continue to play, pick your letter."
    end
  end

  def next_try()
    player_won = false
    @tries.times do
      guess = gets.chomp
      @tries -= 1
      p guess.split('')
      p @secretword
      if guess.split('') == @secretword || player_won == true
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "Congrats you saved the hangman. Good guess the secret word is realy '#{@secretword.join()}'"
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        player_won = true
        break
      elsif guess.length > 1
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "WRONG ONE! Try something else"
        puts "#{@holder.join()} you've got #{@tries} tries left "
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      elsif guess.length < 2
        letter_has_been_found = false
        @secretword.each_with_index do |letter, index|
          if letter == guess
            letter_has_been_found = true
            @holder[index] = guess
          end
        end
        if letter_has_been_found == false 
          puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
          puts "There is no such a letter in the secret word! Try something else"
          puts "#{@holder.join()} you've got #{@tries} tries left"
          puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        else
          puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
          puts "Good job"
          puts "#{@holder.join()} you've got #{@tries} tries left"
          puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        end
      end
      if @tries > 0 
        save_game?()
      end
    end
    if @holder == @secretword
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Congrats you saved the hangman. Good guess the secret word is realy '#{@secretword.join()}'"
    elsif player_won == false
      puts "You lost the word was '#{@secretword.join()}'"
    end
  end

  def play
    welcome()
    next_try()
  end

  def to_yaml
    YAML.dump ({
      secretword: @secretword,
      holder: @holder,
      tries: @tries
    })
  end

  def save_game
    File.open("saved.yml", "w").puts(to_yaml)
  end

  def load_game
    loading = YAML.load(File.open(File.join(File.dirname(__FILE__), "saved.yml")))
    @secretword = loading[:secretword]
    @holder = loading[:holder]
    @tries = loading[:tries]
  end


end

game = Hangman.new
game.play




