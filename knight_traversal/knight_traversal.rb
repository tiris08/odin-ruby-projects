class Knight
  attr_reader :position, :parent
  @@steps = -1
  def initialize(position, parent)
    @position = position
    @parent = parent
  end

  def knight_next_moves
    knight_jumps_capabilities = [[-1,-2], [-2,-1], [-2,1], [-1,2], [1,-2], [2,-1], [2,1], [1,2]]
    next_pissible_moves = []
    knight_jumps_capabilities.each do |i|
      if (i[0] + @position[0]) >= 0 && (i[0] + @position[0]) <= 7 && 
        (i[1] + @position[1]) <= 7 && (i[1] + @position[1]) >= 0 
      next_pissible_moves << [(i[0] + @position[0]), (i[1] + @position[1])]
      end
    end 
    next_pissible_moves.map {|e| Knight.new(e, self)}
  end

  def display_parent(current_node)
    display_parent(current_node.parent) unless current_node.parent.nil?
    p current_node.position
    @@steps += 1
  end
  
  def self.steps
    @@steps
  end
end

class Board 
  def knight_moves(start, finish)
    queue = []
    current_node = Knight.new(start, nil)
    until current_node.position == finish
      current_node.knight_next_moves.each {|e| queue.push(e)}
      current_node = queue.shift
    end
  current_node.display_parent(current_node)
  p Knight.steps < 2 ? "You made it in #{Knight.steps} step" : "You made it in #{Knight.steps} steps"
  end
end


game = Board.new
game.knight_moves([4,3],[2,7])
