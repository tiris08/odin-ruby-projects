require_relative '../lib/cell.rb'
require_relative '../lib/extentions.rb'
class Board
  attr_reader :grid
  def initialize
    @grid = default_grid
  end

  def output_grid
    puts " 0   1   2   3   4   5   6"
    grid.each do |row|
      puts row.map { |cell| cell.value.empty? ? "|_|" : "|#{cell.value}|" }.join(" ")
    end
  end

  def game_over?
    return :winner if winner?
    return :draw if draw?
    false
  end  

  def set_cell(x, value)
    return false if !get_last_empty_column_cell(x)
    get_last_empty_column_cell(x).value = value
  end
 
  def get_last_empty_column_cell(x)
    i = 6
    while i >= 0 do
      i -= 1 
      break if grid[i][x].value.empty?
    end
    return false if i < 0 
    grid[i][x]
  end

  private

  def default_grid
    Array.new(6) {Array.new(7) {Cell.new}}
  end

  def winning_positions
    grid + 
    grid.transpose + 
    diagonals 
  end

  def diagonals
    [
      [grid[3][0], grid[2][1], grid[1][2], grid[0][3]],
      [grid[4][0], grid[3][1], grid[2][2], grid[1][3], grid[0][4]],
      [grid[5][0], grid[4][1], grid[3][2], grid[2][3], grid[1][4],grid[0][5]],
      [grid[5][1], grid[4][2], grid[3][3], grid[2][4], grid[1][5],grid[0][6]],
      [grid[5][2], grid[4][3], grid[3][4], grid[2][5], grid[1][6]],
      [grid[5][3], grid[4][4], grid[3][5], grid[2][6]],
      [grid[0][3], grid[1][4], grid[2][5], grid[3][6]],
      [grid[0][2], grid[1][3], grid[2][4], grid[3][5], grid[4][6]],
      [grid[0][1], grid[1][2], grid[2][3], grid[3][4], grid[4][5],grid[5][6]],
      [grid[0][0], grid[1][1], grid[2][2], grid[3][3], grid[4][4],grid[5][5]],
      [grid[1][0], grid[2][1], grid[3][2], grid[4][3], grid[5][4]],
      [grid[2][0], grid[3][1], grid[4][2], grid[5][3]]
    ]
  end
  
  def winner?
    winning_positions.each do |winning_position|
      next if winning_position_values(winning_position).all_empty?
      return true if winning_position_values(winning_position).four_same_in_a_raw?
    end
    false
  end
   
  def winning_position_values(winning_position)
    winning_position.map { |cell| cell.value }
  end

  def draw? 
    grid.flatten.map { |cell| cell.value }.none_empty?
  end
end
