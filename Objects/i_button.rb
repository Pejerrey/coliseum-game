class IButton
  include Clickable #activated
  include DebugDrawable #debug_draw
  include Drawable #draw, i_info
  
  attr_accessor :tag, :body, :image
  def initialize(tag, image, x, y)
    @tag = tag
	@image = image
	@body = i_bounds(x, y)
  end
  
  def update()
    check_activation()
  end
end