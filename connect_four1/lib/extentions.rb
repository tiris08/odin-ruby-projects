class Array
  def all_empty?
    self.all? { |e| e.to_s.empty?}
  end

  def any_empty?
    self.any? { |element| element.to_s.empty? }
  end
  
  def none_empty?
    !any_empty?
  end
  
  def four_same_in_a_raw?
    x = 0
    o = 0
    self.each do |e| 
      if e == "X"
        o = 0
        x += 1 
        break if x == 4
      elsif e == "O"
        x = 0
        o += 1
        break if o == 4
      end
    end
    
    x == 4 || o == 4 ? true : false
  end

end