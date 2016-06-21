class Segment
  include Constants
  
  attr_accessor :a, :b, :c
  def initialize(x1, y1, x2, y2, c = RED)
    @a = { :x => x1, :y => y1 }
	@b = { :x => x2, :y => y2 }
	@c = c
  end
  
  def draw
    Gosu::draw_line(@a[:x], @a[:y], c, @b[:x], @b[:y], c, 100) if $DEBUG_MODE
  end
end