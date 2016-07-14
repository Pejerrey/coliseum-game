class FlippedStill < Still
  def draw(x, y)
    @image.draw(x + width/2, y - height/2, @z, -1)
  end
end