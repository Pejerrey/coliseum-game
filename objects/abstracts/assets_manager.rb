module AssetsManager
  SCALE_A = 1.6
  SCALE_B = 0.8
  
  def load_assets()
    load_set(:idle, "test/test_idle", 0, SCALE_A, SCALE_A)
	load_anim_set(:walk, ["test/test_idle", 400,
	                      "test/test_walk1", 400,
	                      "test/test_idle", 400,
						  "test/test_walk2", 400], 0, SCALE_A, SCALE_A)
	load_set(:run, "test/test_run", 0, SCALE_B, SCALE_B)
  end
  
  
  private
  def load_set(pre_tag, pre_filename, z = 0, scale_x = 1, scale_y = 1)
    assets[:"#{pre_tag}_front"] = Still.new(pre_filename + "_front.bmp", z, scale_x, scale_y)
    assets[:"#{pre_tag}_left"] = Still.new(pre_filename + "_side.bmp", z, -scale_x, scale_y)
	assets[:"#{pre_tag}_right"] = Still.new(pre_filename + "_side.bmp", z, scale_x, scale_y)
	assets[:"#{pre_tag}_back"] = Still.new(pre_filename + "_back.bmp", z, scale_x, scale_y)
  end
  
  def load_anim_set(pre_tag, pre_sequence, z = 0, scale_x = 1, scale_y = 1)
    ["front", "left", "right", "back"].each do |dir|
	  suf_file = (dir == "left" || dir == "right") ? "side" : dir 
	  fscale_x = dir == "left" ? -scale_x : scale_x
	  sequence = pre_sequence.dup()
      (0...sequence.size).step(2).each do |i|
	    sequence[i] += "_" + suf_file + ".bmp"
	  end
	  assets[:"#{pre_tag}_#{dir}"] = Loop.new(sequence, z, scale_x, scale_y)
	end
  end
end