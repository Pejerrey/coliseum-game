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
	segments.each do |segment|
	  a_s = segment.a
	  b_s = segment.b
	  if (a_s[:x]-b_s[:x]) == 0 then next end
	  edge_wannabe = (point[:x] - a_s[:x]) * (a_s[:y]-b_s[:y])/(a_s[:x]-b_s[:x]) + a_s[:y]
	  
	if vertex[0][:x] == 163
	  puts "Behold: "
	  puts edge_wannabe
	  puts a_s[:y] - b_s[:y]
	  puts a_s[:x]-b_s[:x]
	  puts (a_s[:y]-b_s[:y]) / (a_s[:x]-b_s[:x])
	  puts ""
	end
	  
	  
	  if edge_wannabe.in_between?(a_s[:y], b_s[:y]) ||
	     (a_s[:y] == b_s[:y] && point[:x].in_between?(a_s[:x], b_s[:x]))
	    if edge_wannabe < point[:y]
	      y_edges << edge_wannabe
		end
	  end
	end
	return y_edges.size % 2 == 1
  end
  
  def draw()
    segments.each { |segment| segment.draw() }
  end
end

# A polygon requires at least 3 vertex