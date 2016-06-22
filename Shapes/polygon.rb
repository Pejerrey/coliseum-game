class Polygon
  attr_accessor :vertex
  def initialize(args)
    vertex = []
	until args.empty?
	  x = args.shift
	  y = args.shift
	  raise "Odd number of argumens for vertex initialization" if y == nil
	  @vertex << { :x => x, :y => y}
	end
	raise "Less than three vertex provided" if vertex.size < 3
  end
  # A polygon requires at least 3 vertex
  
  def segments
    arr = []
    (0...vertex.size-1).each do |i|
	  a = vertex[i]
	  b = vertex[i+1]
	  arr << Segment.new(a[:x], a[:y], b[:x], b[:y])
	end
    a = vertex.last
	b = vertex.first
	arr << Segment.new(a[:x], a[:y], b[:x], b[:y])
	return arr
  end
  
  def holds?(point)
    #Vertical ray casting from above
	y_edges = []
	segments.each do |seg|
	  if seg.a[:x] - seg.b[:x] != 0                     #Disregard vertical segments
	    if point[:x].in_between?(seg.a[:x], seg.b[:x])  #Ray and segment may intersect
		  edge = seg.a[:y] + (point[:x] - seg.a[:x]) *
		         ((seg.a[:y] - seg.b[:y])/(seg.a[:x] - seg.b[:x]))
		  y_edges << edge if edge < point[:y]
	    end
	  end
	end
	return y_edges.size % 2 == 1
  end
  
  def intersects?(seg)
    
  end
  
  def draw()
    segments.each { |segment| segment.draw() }
  end
end