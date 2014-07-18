require 'artoo'
require 'vlc-client'

connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion

work do
  on leapmotion, :open => :on_open
  on leapmotion, :gesture => :on_gesture
  on leapmotion, :close => :on_close
end

def on_open(*args)
pid = fork{ exec 'afplay', "audio/harder_better_faster_stronger.mp3" }

@vlc = VLC::System.new
@vlc.connect
@vlc.volume(200)
@songs = %w{ after.wav
            better.wav
            do_it.wav
            ever.wav
            faster.wav
            harder.wav
            hour.wav
            make_it.wav
            makes_us.wav
            more_than.wav
            never.wav
            our.wav
            over.wav
            stronger.wav
            work_is.wav
            work_it.wav
            over.wav
          }
end 


def on_close(*args)
  @vlc1.disconnect
  @vlc.disconnect
end

def on_gesture(*args)
  gesture = args[1]
  # puts gesture.type
  case gesture.type
    when "keyTap"
      song = "audio/#{@songs.sample}"
      puts song
      @vlc.clear
      @vlc.play(song) unless @vlc.playing?
  end
end