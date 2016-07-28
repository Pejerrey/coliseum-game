class IButton
  include Clickable #activated
  include DebugDrawable #debug_draw
  include Drawable #draw, i_info
  
  attr_accessor :body, :image
  def initialize(image, x, y)
	@image = image
	@body = i_bounds(x, y)
  end
  
  def update()
    check_activation()
  end
end