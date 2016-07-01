module Controllable
  #Needs: controller
  def control_update()
    controller.update()
  end
  
  def last_input?(key)
    return controller.command_list.size > 0 &&
	       controller.command_list.last.include?(key)
  end
  
  def up
    controller.up
  end
  
  def down
    controller.down
  end
  
  def left
    controller.left
  end
  
  def right
    controller.right
  end
  
  def a
    controller.a
  end
  
  def b
    controller.b
  end
  
  def c
    controller.c
  end
  
  def up?
    controller.active_keys.include?(up)
  end
  
  def down?
    controller.active_keys.include?(down)
  end
  
  def left?
    controller.active_keys.include?(left)
  end
  
  def right?
    controller.active_keys.include?(right)
  end
  
  def a?
    controller.active_keys.include?(a)
  end
  
  def b?
    controller.active_keys.include?(b)
  end
  
  def c?
    controller.active_keys.include?(c)
  end
end