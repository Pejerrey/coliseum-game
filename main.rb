require 'gosu'

#Screen settings constants
WIDTH = 800
HEIGHT = 600
CAPTION = "TEST"

#Dynamically require
root_dir = File.dirname(File.expand_path(__FILE__))
require_pattern = File.join(root_dir, '**/*.rb')
@failed = []
Dir.glob(require_pattern).each do |f|
  next if f.end_with?('/main.rb')
  begin
    require_relative f.gsub("#{root_dir}/", '')
  rescue
    @failed << f	# May fail if parent class not required yet
  end
end
@failed.each do |f|
  require_relative f.gsub("#{root_dir}/", '')
end

#Global flags
$DEBUG_MODE = false
$FULLSCREEN = false
unless ARGV.empty?
  ARGV.each do |string|
    $DEBUG_MODE = true if string == '-d'
	$FULLSCREEN = !$FULLSCREEN if string == '-f'
  end
end

##Main loop
$window = GameWindow.new(WIDTH, HEIGHT, CAPTION, $FULLSCREEN)
$window.add_scene(SceneIntro.new())
$window.show() 