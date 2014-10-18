require 'json'
require 'httparty'

def sanitize_quote(quote)
  quote.gsub(/\n\t.+/, '')
end

def get_quote
  api_call = "http://iheartquotes.com/api/v1/random?format=json&source=literature+liberty&max_lines=5"
  quote = HTTParty.get(api_call)
  sanitize_quote(quote.parsed_response["quote"])
end

quote_array = []

1000.times do |x|
  quote_array << get_quote
  if x % 10 == 0
    print "."
  end
end

json_array = quote_array.uniq.to_json

File.write('./quotes.json', json_array)
