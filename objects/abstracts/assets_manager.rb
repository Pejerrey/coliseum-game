module AssetsManager
  SCALE_A = 1.6
  SCALE_B = 0.8
  
  def load_assets()
    @assets =
	  [Still.new(:idle_front, "test/test_idle_front.bmp", 0, SCALE_A, SCALE_A) ,
	   Still.new(:idle_left, "test/test_idle_side.bmp", 0, -SCALE_A, SCALE_A) ,
	   Still.new(:idle_right, "test/test_idle_side.bmp", 0, SCALE_A, SCALE_A) ,
	   Still.new(:idle_back, "test/test_idle_back.bmp", 0, SCALE_A, SCALE_A) ,
		
	   Loop.new(:walk_front, ["test/test_idle_front.bmp", 400,
		                       "test/test_walk1_front.bmp", 400,
							   "test/test_idle_front.bmp", 400,
							   "test/test_walk2_front.bmp", 400], 0, SCALE_A, SCALE_A) ,
	   Loop.new(:walk_left, ["test/test_idle_side.bmp", 400,
		                       "test/test_walk1_side.bmp", 400,
							   "test/test_idle_side.bmp", 400,
							   "test/test_walk2_side.bmp", 400], 0, -SCALE_A, SCALE_A) ,
	   Loop.new(:walk_right, ["test/test_idle_side.bmp", 400,
		                       "test/test_walk1_side.bmp", 400,
							   "test/test_idle_side.bmp", 400,
							   "test/test_walk2_side.bmp", 400], 0, SCALE_A, SCALE_A) ,
	   Loop.new(:walk_back, ["test/test_idle_back.bmp", 400,
		                      "test/test_walk1_back.bmp", 400,
							  "test/test_idle_back.bmp", 400,
							  "test/test_walk2_back.bmp", 400], 0, SCALE_A, SCALE_A) ,
		
	   Still.new(:run_front, "test/test_run_front.bmp", 0, SCALE_B, SCALE_B) ,
	   Still.new(:run_left, "test/test_run_side.bmp", 0, -SCALE_B, SCALE_B) ,
	   Still.new(:run_right, "test/test_run_side.bmp", 0, SCALE_B, SCALE_B) ,
	   Still.new(:run_back, "test/test_run_back.bmp", 0, SCALE_B, SCALE_B) ,
		
	   Still.new(:thrust_front, "test/test_thrust_front.bmp", 0, SCALE_B, SCALE_B) ,
	   Still.new(:thrust_left, "test/test_thrust_side.bmp", 0, -SCALE_B, SCALE_B) ,
	   Still.new(:thrust_right, "test/test_thrust_side.bmp", 0, SCALE_B, SCALE_B) ,
	   Still.new(:thrust_back, "test/test_thrust_back.bmp", 0, SCALE_B, SCALE_B)]
  end
end