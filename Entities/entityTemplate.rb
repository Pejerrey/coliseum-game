class Entity
  ##Initialization
  attr_accessor :width, :height, :mass, :shape, :image
  attr_accessor :x, :y, :angle, :speedx, :speedy, :prev_speedx, :prev_speedy
  
  SLIDE_THRESHOLD = 0.5
  
  def initialize(width, height, mass, shape, image, x, y, angle)
    @width = width #px
	@height = height #px
	@mass = mass
	@shape = shape
	@image = image
	@x = x #px
	@y = y #px
	@angle = angle
	@speedx = 0 #px/s 
	@speedy = 0 #px/s
	@prev_speedx = 0 #px/s 
	@prev_speedy = 0 #px/s
  end
  
  
  ##Getters & Setters
  def left() @x - @width/2.0 end
  def right() @x + @width/2.0 end
  def top() @y - @height/2.0 end
  def bottom() @y + @height/2.0 end
  def left=(left) @x = left + @width/2.0 end
  def right=(right) @x = right - @width/2.0 end
  def top=(top) @y = top + @height/2.0 end
  def bottom=(bottom) @y = bottom - @height/2.0 end
  
  
  ##Public Methods
  def drag(floor)
	drag = floor.slide
	@speedx = ((@speedx * drag).abs) > SLIDE_THRESHOLD ? @speedx * drag : 0
	@speedy = ((@speedy * drag).abs) > SLIDE_THRESHOLD ? @speedy * drag : 0
  end
  
  def travel()
    average_speedx = Utils.average(@prev_speedx, @speedx)
	average_speedy = Utils.average(@prev_speedy, @speedy)
	@x += average_speedx * Pacemaker.elapsed								######
    @y += average_speedy * Pacemaker.elapsed								######
  end
  
  def saveSpeed()
    @prev_speedx = @speedx
	@prev_speedy = @speedy
  end
  
  def draw()
    #@image.draw_rot(@x, @y, 1, 0)
	Utils.draw_rect(@x, @y, @width, @height, Gosu::Color::CYAN) if $COLLISION_BOX
  end
end