require './twitter_keys'
require 'twitter'
require 'mini_magick'


# rails' word wrap helper
def word_wrap(text, line_width)
        text.split("\n").collect do |line|
          line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
  end * "\n"
end

possible_images = Dir["./images/*.jpg"]

puts "possible images"
possible_images.map!{|x| x.gsub("./images/", "")}

p possible_images

image = MiniMagick::Image.open("./images/#{possible_images.sample}")

quotes = File.open('quotes.json')
json_quotes = quotes.read
parsed_quotes = JSON.parse(json_quotes)

random_quote = parsed_quotes.sample.gsub(/\n/, '')

figures = ["Darth Vader", "Carl Sagan", "Richard Dawkins", "Barack Obama"]

caption = word_wrap(random_quote, 30)
figure = "-" + figures.sample

image.combine_options do |c|
  c.font './fonts/georgia.ttf'
  c.gravity 'south'
  c.pointsize '30'
  c.fill 'black'
  c.annotate '0,0', "#{caption} \n#{figure}"
  c.fill 'white'
  c.annotate '0,0,1,1', "#{caption} \n#{figure}"
  c.gravity 'south'
  c.pointsize '40'
end

image.write("from_internets.jpg")



