class Text < Still
  ##Constructor
  def initialize(text, size, z = 0, x_scale = 1, y_scale = 1)
    @image = Gosu::Image.from_text(text, size)
	@z = z
	@x_scale = x_scale
	@y_scale = y_scale
  end
end