require './twitter_keys'
require 'twitter'
require 'mini_magick'

# rails' word wrap helper
def word_wrap(text, line_width)
        text.split("\n").collect do |line|
          line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
  end * "\n"
end

url = "https://pbs.twimg.com/profile_images/378800000513309824/9b647a46039e62a4dfc1b4e7b0093d27.png"

image = MiniMagick::Image.open('./images/vader.jpg')

caption = "its a far far better thing I do now than I have ever done before and such."
caption = word_wrap(caption, 30)

puts caption

p caption

caption2 = word_wrap(caption, 8)

p caption2

image.combine_options do |c|
  c.font './fonts/comic.ttf'
  c.gravity 'center'
  c.pointsize '69'
  c.fill 'white'
  c.annotate '0,0', "#{caption}"
  c.fill 'black'
  c.annotate '0,3', "#{caption}"


end

image.write("from_internets.jpg")



