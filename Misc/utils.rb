require 'gosu'

module Utils
  #Math Section
  def self.in_between?(c, a, b)
    return (c <= a && b <= c) || (c <= b && a <= c)
  end
  
  def self.hypotenuse(a, b)
    Math.sqrt(a**2 + b**2)
  end
  
  def self.polarizeVector(sideX, sideY)
    length = Utils.hypotenuse(sideX, sideY)
	angle = Utils.angleVector(sideX, sideY)
	return length, angle
  end
  
  def self.angleVector(sideX, sideY)
	if sideX == 0 && sideY == 0 
	  angle = 0
	elsif sideX == 0 
	  angle = sideY > 0 ? Utils.toRadians(90) : Utils.toRadians(270)
	elsif sideY == 0
	  angle = sideX > 0 ? 0 : Utils.toRadians(180)
	else
	  if sideX > 0
	    angle = Math.atan(sideY/sideX)
	  else
	    angle = Math.atan(sideY/-sideX)
	    angle = Math::PI - angle
	  end
	end
	return angle
  end

  def self.quadraticFormula(a, b, c)
    (-b + Math.sqrt(b**2 - 4 * a * c)) / (2 * a)
  end
  
  def self.average(previous, current)
    previous + (current - previous) / 2.0
  end
  
  def self.equalSign?(a, b)
    (a >= 0 && b >=0) || (a < 0 && b < 0) 
  end
  
  def max(*args)
    max = args[0]
	args.each do |a|
	  if a > max then max = a end
	end
  end
  
  def self.abs_subtract(a, b)
    a >= 0 ? a - b : a + b
  end
  
  def self.toRadians(degrees)
    Math::PI * degrees/180.0
  end
  
  def self.inside_rect?(p, r)
  	return false unless p.x > r.left
    return false unless p.x < r.right
	return false unless p.y < r.bottom
	return false unless p.y > r.top
	return true
  end
  
  
  #Media Section
  def self.get_image(file)
    Gosu::Image.new(get_media(file), :tileable => true)
  end
  
  def self.get_song(file)
    Gosu::Song.new(get_media(file))
  end
  
  def self.get_sample(file)
    Gosu::Sample.new(get_media(file))
  end
  
  
  #Rendering Section
  def self.draw_rect(rectangle, z = 100)
    x = rectangle.x
	y = rectangle.y
	width = rectangle.width
	height = rectangle.height
	color = rectangle.color
	Gosu::draw_line(x - width/2, y + height/2, color, x + width/2, y + height/2, color, z)
    Gosu::draw_line(x + width/2, y + height/2, color, x + width/2, y - height/2, color, z)
    Gosu::draw_line(x + width/2, y - height/2, color, x - width/2, y - height/2, color, z)
    Gosu::draw_line(x - width/2, y - height/2, color, x - width/2, y + height/2, color, z)
  end
  
  def self.draw_circ(circle, z = 100)
  	#Circle equation: x^2 + y^2 = r^2
	#    => sqrt(r^2 - x^2) = y
	
	radius = circle.radius
	color = circle.color
		
	stp = radius/10.0
	[-1,1].each do |sign|
	  (-radius...radius).step(stp) do |x|
	    a = { :x => x,  :y => sign * circ_f(x, radius) }
	    b = { :x => x + stp,  :y => sign * circ_f(x + stp, radius) }
	    a[:x] += circle.x
	    a[:y] += circle.y
	    b[:x] += circle.x
	    b[:y] += circle.y
	    Gosu::draw_line(a[:x], a[:y], color, b[:x], b[:y], color, z)
	  end
	end
  end
  
  def self.circ_f(x, r) #Positive only
    return Math.sqrt(r**2 - x**2)
  end
end