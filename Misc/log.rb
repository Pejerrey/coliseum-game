require 'pp'

class Log
  def initialize()
    @explorer = [$window]
	@user_input = false
	@stalking = false
	@stalked = []
  end
  
  def log()
    if @stalking
	  stalk()
	  return
	end
	
    if @user_input
	  input = STDIN.gets().chomp()
	  if input == "self"       #Info about self
	    pp current_object()
		print "Finished printing."
		STDIN.gets()
	  elsif input == "refresh" #Refresh
	  elsif input.is_i? && (0...attribute_list().size).include?(input.to_i) #Step Into
		@explorer << attribute_list()[input.to_i]
	  elsif input == "back"    #Step back
	    @explorer.pop() unless @explorer.size == 1 
	  elsif input == "window"  #Return
	    @explorer.pop() until @explorer.size == 1
	  elsif input == "stalk"
	    @stalking = true
	  elsif input == "track"   #Track stalked
	    @stalked << current_object()
	  elsif input == "undo"    #Undo stalked
	    @stalked.pop()
	  elsif input == "clear"   #Clear stalked
	    @stalked.clear()
	  elsif input == "exit"    #Exit
	    exit
	  elsif input == "help"    #Help
	    puts ""
		print "Commands: self, refresh, #n, back, window, track, clear, undo, exit "
		STDIN.gets()
	  else                     #Invalid Command
	    puts ""
		if input.is_i?
	      puts "Invalid index"
	    else 
		  puts "The input doesn't match any valid command"
	    end
		print "Please, issue a new command: "
		return
	  end
	  @user_input = false
	  
	else
	  system "cls"
	  print "Tracking: "
	  sp @stalked
	  puts ""
	  print "CURRENT OBJECT: "
	  puts current_object()
	  if attribute_list()
	    puts "Attributes"
	    print " "
	    print attribute_name()
	    print ": "
	    sp attribute_list()
	  end
	  print "What do you want to inspect? "
	  @user_input = true
	end
  end
  
  def stalk()
    system "cls"
	@stalked.each_with_index do |object, i|
	  print "OBJECT #"
	  print i
	  print ": "
	  puts object
	  pp object
	  puts ""
	end
	sleep 0.3
  end
  
  
  private
  def current_object()
    @explorer.last()
  end
  
  def attribute_name()
    if current_object().is_a?(GameWindow)
	  return "Scenes"
	elsif current_object().is_a?(Scene)
	  return "Object Pool"
	else
	  return nil
	end
  end
  
  def attribute_list()
    if current_object().is_a?(GameWindow)
	  return current_object().scenes
	elsif current_object().is_a?(Scene)
	  return current_object().object_pool
	else
	  return nil
	end
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