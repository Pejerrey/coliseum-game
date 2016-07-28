class Picture
  include Drawable
  
  attr_accessor :body, :image
  
  def initialize(image, x, y)
	@body = Circle.new(x, y, 1)
	@image = image
  end
end