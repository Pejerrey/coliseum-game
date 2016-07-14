class Picture
  include Drawable
  
  attr_accessor :tag, :body, :image
  
  def initialize(tag, type, *args, x, y)
    @tag = tag
	@body = Circle.new(x, y, 1)
	case type
	when :still
	  raise "Wrong init of Picture, type still, #{args.size} arguments" if args.size > 2 
	  filename, z = args
	  @image = Still.new(filename, z || 0)
	when :text
	  raise "Wrong init of Picture, type text, #{args.size} arguments" if args.size > 3
	  text, size, z = args
	  @image = Text.new(text, size, z || 0)
	else
	  raise "Wrong initialization of Picture, unknown type #{type}"
	end
  end
end