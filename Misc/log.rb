require 'pp'

class Log
  def initialize(window)
    @window = $window
	@director = :init
	@user_input = false
	@current_object = window
	@stalked = []
  end
  
  def log()
    case @director
	
	when :init, :window
	  case @user_input
	  when false
	    system "cls"
	  	puts ""
	    print "CURRENT OBJECT: "
		puts @current_object
		puts "Attributes"
		print " Scenes: "
		sp $window.scenes
		puts " Input"
	    print "What do you want to inspect? "
		@user_input = true
	  when true
	    case STDIN.gets().chomp()
		when "self"
		  pp $window
		  print "Finished printing."
		  STDIN.gets()
		else
		  @director = :invalid
		end
		@user_input = false
	  end
	  
	else
	  puts ""
	  puts "The input doesn't match any valid command"
	  print "Returning to Main Window..."
	  STDIN.gets()
	  @director = :window
	  
	end
  end
  
  def stalk()
  end

  def sp(arr)
    print "["
	arr.each_with_index do |elem, i|
	  print elem
	  print "," unless i == arr.size - 1
	end
	puts "]"
  end
end