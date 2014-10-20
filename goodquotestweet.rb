require './twitter_keys'
require 'twitter'
require 'mini_magick'
require 'tempfile'
require 'open-uri'
require 'HTTParty'


# rails' word wrap helper
def word_wrap(text, line_width)
        text.split("\n").collect do |line|
          line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
  end * "\n"
end


def return_random_author
  authors = open(SITE_URL + '/authors.json')
  json_authors = authors.read
  p JSON.parse(json_authors).length
  JSON.parse(json_authors).sample
end

def return_random_quote
  quotes = open(SITE_URL + '/quotes.json')
  json_quotes = quotes.read
  p JSON.parse(json_quotes).length
  JSON.parse(json_quotes).sample.gsub(/\n/, '')
end

def return_random_image_location
  possible_images = [SITE_URL + "/img/*.jpg"]
  possible_images.sample
  "http://lucasquinn.com/quotebot/img/cicero.jpg"
end

def return_random_image
  possible_images = HTTParty.get(SITE_URL + "/img")
  scanned_images = possible_images.scan(/href=\"(.+\.jpg)\"/)
  SITE_URL + "/img/" + scanned_images.sample.first
end

def configure_twitter_client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = 'accrpZT4WCq4jzwqkanqqJsVj'
    config.consumer_secret = 'WKRVFUuO7BilWk1zyzDAZLupLBSCYvzvSA9tSArRu09d16e2bK'
    config.access_token = '2836011196-dwbM8kGVuC3pez4ML26M6EiT6JJugxS2j7FWrYn'
    config.access_token_secret = '9jHjW1ncFLhjKwFOpBLr0tGUDF8cXU68JAhrQRz5i4988'
  end
end

def add_hashtags
  hashtags = ["#inspirational", "#motivational", "#wise", "#encouragement", "#wisdom", "#content", "#driven", "#life", "#knowledge", "#intelligence", "#acumen", "#circumspection", "#inspired", "#wow", "#cool", "#nowyouknow", "#death", "#makesyouthink", "#poise", "#clearly", "#success", "#discipline", "#teamwork", "#leadership", "#passion", "#harmony", "#luck", "#mondays", "#moderation", "#perseverance", "#courage", "#love", "#leadership", "#individuality", "#disrupt", "#startup", "#business", "#obama", "#traction", "#viral", "#wow", "#excellent"].shuffle
  these_tags = []
  4.times {these_tags.push(hashtags.shift)}
  these_tags.join(" ")
end

def get_font
  SITE_URL + "/fonts/timesbold.ttf"
end

def tweet(client)
  image = MiniMagick::Image.open("#{return_random_image}")

  author = return_random_author
  caption = word_wrap(return_random_quote, 30)
  full_quotation = "#{caption} \n -#{author}"

  image.combine_options do |c|
    c.font get_font
    c.gravity 'center'
    c.pointsize '<35></35>'
    c.fill 'black'
    c.annotate '0,0', full_quotation
    c.fill 'white'
    c.annotate '0,0,1,1', full_quotation
  end

  file = image.write("./tmp/tweet_pic.jpg")

  File.open("./tmp/tweet_pic.jpg") do |f|
      client.update_with_media("#{add_hashtags} quote from #{author}", f)
    end
end

def make_tweet
  client = configure_twitter_client
  tweet(client)
end

make_tweet

# return_random_image