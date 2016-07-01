class WorldPlaytest < World
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << TestPlayer.new(:r_poly, Rectangle.new(250, 300, 40, 30))
	  obj(:r_poly).apply_force(Vector.new(100, 4))
	when :intro
	  #Things go here
	  #if(obj(:r_poly).a? 
	
	else unknown_director()
	end
  end
end