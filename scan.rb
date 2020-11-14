require 'mini_magick'

@VERBOSE = false

def check(file)
  image = MiniMagick::Image.open(file)
  long  = image[:width]
  short = image[:height]
  if (long < short)
    long  = image[:height]
    short = image[:width]
  end
  ratio   = (1.0*long)/short
  if ((1.50 - ratio).abs > 0.1)
    puts "!!   #{'%.3f' % ratio}\t#{long}\t#{short}\t#{file}"
  else
    if (@VERBOSE)
      puts "ok   #{'%.3f' % ratio}\t#{long}\t#{short}\t#{file}"
    end
  end
end

def scan()
  list = Dir["./**/*.jpg"]
  list.each do |file|
    check(file)
  end
end

target = "http://www.windygallery.com"
if (ARGV.length > 0)
  @VERBOSE = true
  scan()
else
  scan()
end
