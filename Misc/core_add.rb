class String
    def is_i?
       /\A\d+\z/ === self
    end
end

class Float
  def similar?(other, epsilon = 1e-6)
    (self - other.to_f).abs < epsilon.to_f
  end
  
  def in_between?(a, b)
    return (a >= self && b <= self) || (a <= self && b >= self)
  end
end