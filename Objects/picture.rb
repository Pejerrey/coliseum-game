class Picture
  include Drawable #draw, i_width, i_height, i_bounds
  
  attr_accessor :tag, :body, :image
  def initialize(tag, image, x, y)
    @tag = tag
	@body = Circle.new(x, y, 1)
	@image = image
  end
end