class TestPlayer < Player
  def control(pool)
    control_update()
	#Movement
	f_input = Vector.new(0, 0)
	f_input.x -= 20 if left? && (!last_input?(right) || !right?)
	f_input.x += 20 if right? && (!last_input?(left) || !left?)
    f_input.y -= 20 if up? && (!last_input?(down) || !down?)
	f_input.y += 20 if down? && (!last_input?(up) || !up?)
	apply_force(f_input)
	#Max Velocity
	velocity.trim(150)
  end
end