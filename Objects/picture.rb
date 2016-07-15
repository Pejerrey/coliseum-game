class Picture
  include Drawable
  
  attr_accessor :tag, :body, :image
  
  def initialize(tag, image, x, y)
    @tag = tag
	@body = Circle.new(x, y, 1)
	@image = image
  end
end