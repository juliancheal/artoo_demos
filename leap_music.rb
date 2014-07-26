require 'artoo'
require 'vlc-client'

class SpheroRobot < Artoo::Robot

connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion

def initialize
  @timings = [51,52,53,54,59,60,61,62,66,67,68,68,74,75,75,77]
  @count = 0
  @lyrics = ["Work It", "Make It", "Do It", "Makes Us", "Harder", "Better", "Faster", "Stronger", "More Than", "Hour", "Our", "Never", "Ever", "After", "Work is" , "Over"]
  super
end

work do

  on leapmotion, :open => :on_open
  on leapmotion, :gesture => :on_gesture
  # on leapmotion, :close => :on_close
  pid = fork{ exec 'afplay', "audio/04 Harder, Better, Faster, Stronger.mp3" }

  # after(51.seconds) { @timings.shift }
  # after(52.seconds) { @timings.shift }
  # after(53.seconds) { @timings.shift}
  # after(54.seconds) { @timings.shift }
  # after(59.seconds) { @timings.shift }
  # after(60.seconds) { @timings.shift }
  # after(61.seconds) { @timings.shift }
  # after(62.seconds) { @timings.shift }
  # after(66.seconds) { @timings.shift }
  # after(67.seconds) { @timings.shift }
  # after(68.seconds) { @timings.shift }
  # after(68.seconds) { @timings.shift }
  # after(74.seconds) { @timings.shift }
  # after(75.seconds) { @timings.shift }
  # after(75.seconds) { @timings.shift }
  # after(77.seconds) { @timings.shift }
  every(1.second) {puts count_increment}
end

def count
  @count
end

def count_increment
  @count = @count + 1
end

def on_open(*args)
  # @count = 0
  # # @timings = [51,52,53,54,59,60,61,62,66,67,68,68,74,75,75,77]
  # @lyrics = ["Work It", "Make It", "Do It", "Makes Us", "Harder", "Better", "Faster", "Stronger", "More Than", "Hour", "Our", "Never", "Ever", "After", "Work is" , "Over"]
# pid = fork{ exec 'afplay', "audio/harder_better_faster_stronger.mp3" }

# @vlc = VLC::System.new
# @vlc.connect
# @vlc.volume(200)
# @songs = %w{ after.wav
#             better.wav
#             do_it.wav
#             ever.wav
#             faster.wav
#             harder.wav
#             hour.wav
#             make_it.wav
#             makes_us.wav
#             more_than.wav
#             never.wav
#             our.wav
#             over.wav
#             stronger.wav
#             work_is.wav
#             work_it.wav
#             over.wav
#           }
end 


def on_close(*args)
  @vlc1.disconnect
  @vlc.disconnect
end

def on_gesture(*args)
  # puts @timings.inspect
  # closeness(@timings, @count)
  # guess = @count
  # timing = @timings
  # puts @timings.inspect
  # puts @count.inspect
  if @timings.include?(@count) || @timings.include?(@count-1) || @timings.include?(@count+=1)
    puts "Success!"
  else
    puts "Fail :("
  end
end

def closeness(timing, count)
  guess = count
  timing = timing.first
  
  if guess == timing || guess == timing-1 || guess == timing+=1
    puts "Success!"
  else
    puts "Fail :("
  end
end

# def on_gesture(*args)
#   gesture = args[1]
#   # puts gesture.type
#   case gesture.type
#     when "keyTap"
#       song = "audio/#{@songs.sample}"
#       puts song
#       @vlc.clear
#       @vlc.play(song) unless @vlc.playing?
#   end
# end
end

robot = SpheroRobot.new
SpheroRobot.work!(robot)