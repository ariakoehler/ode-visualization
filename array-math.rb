# implements numpy-style arithmetic methods to ruby built-in arrays for easier operations

module ArrayMath

  # straightforward addition
  def add (other)
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p + other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p + self[i]}
      end
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p + other }
    else
      raise "Invalid class to be adding to this array."
    end
  end

  # straightforward subtraction
  def sub (other)
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p - other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p - self[i]}
      end
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p - other }
    else
      raise "Invalid class to be subtracting from this array."
    end
  end

  # straightforward multiplication  
  def mul (other)
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p * other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p * self[i]}
      end
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p * other }
    else
      raise "Invalid class to be multiplying to this array."
    end
  end

  # straightforward division  
  def div (other)
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p / other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p / self[i]}
      end
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p / other }
    else
      raise "Invalid class to be dividing from this array."
    end
  end

end

class Array
  include ArrayMath
end


# a = [1,2,3]
# b = [4,5,6,7]
# c = 5.2

# d = a.add(b)
# puts d
# f = a.add(c)
# puts f
