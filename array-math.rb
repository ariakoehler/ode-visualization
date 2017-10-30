# implements numpy-style arithmetic methods to Ruby built-in arrays for easier operations

module ArrayMath

  # straightforward addition
  def add (other)
    # add smaller array of size n to first n elements of larger array
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p + other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p + self[i]}
      end
    # broadcast ints and floats to operate on each element
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p + other }
    else
      raise "Invalid class to be adding to this array."
    end
  end

  # straightforward subtraction
  def sub (other)
    # add smaller array of size n to first n elements of larger array
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p - other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p - self[i]}
      end
    # broadcast ints and floats to operate on each element
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p - other }
    else
      raise "Invalid class to be subtracting from this array."
    end
  end

  # straightforward multiplication  
  def mul (other)
    # add smaller array of size n to first n elements of larger array
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p * other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p * self[i]}
      end
    # broadcast ints and floats to operate on each element
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p * other }
    else
      raise "Invalid class to be multiplying to this array."
    end
  end

  # straightforward division  
  def div (other)
    # add smaller array of size n to first n elements of larger array
    if(other.class == Array)
      if self.length < other.length
        return self.map.with_index { |p, i| p / other[i]}
      else self.length >= other.length
        return other.map.with_index{ |p, i| p / self[i]}
      end
    # broadcast ints and floats to operate on each element
    elsif(other.class == Float or other.class == Integer)
      return self.map.each { |p| p / other }
    else
      raise "Invalid class to be dividing from this array."
    end
  end

  # retrieve all elements in column n of depth 2 nested array instead of row n
  def vert (index)
    # assumes that all subarrays have an nth element
    ret_arr = []
    self.each { |a| ret_arr << a[index]}
    return ret_arr
  end

end



class Array
  # Add all the new methods to built-in array class
  include ArrayMath
end


# a = [1,2,3]
# b = [4,5,6,7]
# c = 5.2

# d = a.add(b)
# puts d
# f = a.add(c)
# puts f

# l = [[1,2,3],
#      [1,4,9],
#      [1,8,27]]

# puts l.vert(1).inspect
