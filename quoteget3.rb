# encoding UTF-8

require 'httparty'
require 'json'

# quote_url = 'http://www.quotedb.com/quote/quote.php?action=random_quote&=&=&'

class Spinny
  def initialize
    @index = 0
    @positions = ['|', "\\", '-', '/', '-']
  end

  def spin
    if @index <= 4
      icon = @positions[@index]
      @index += 1
      icon
    else
      @index = 0
      icon = @positions[@index]
      @index += 1
      icon
    end
  end
end

spinner = Spinny.new

quotes_file = File.open('quotes.json').read
quotes = JSON.parse(quotes_file)

original_quotes_length = quotes.length

authors_file = File.open('authors.json').read
authors = JSON.parse(authors_file)

original_authors_length = authors.length

def get_quote
  quote_url = "http://www.quotationspage.com/quote/#{rand(30000)}.html"
  raw_quote = HTTParty.get(quote_url)
  quote = /\"&quot;(.+)&quot;/.match(raw_quote.parsed_response)[1] if /\"&quot;(.+)&quot;/.match(raw_quote.parsed_response)
  author = /Quote\sfrom\s(.+)\"/.match(raw_quote.parsed_response)[1] if /Quote\sfrom\s(.+)\"/.match(raw_quote.parsed_response)
  [quote, author]
end

50.times do |x|
  this_quote = get_quote
  quotes << this_quote[0].force_encoding('UTF-8') if this_quote[0]
  p this_quote[0].force_encoding('UTF-8') if this_quote[0]
  authors << this_quote[1].force_encoding('UTF-8') if this_quote[1]
  p this_quote[1].force_encoding('UTF-8') if this_quote[1]
  print spinner.spin
  if x % 10 == 0
    puts x
  end
end

json_quotes_array = quotes.uniq
json_authors_array = authors.uniq


puts "quotes length"
puts "from #{original_quotes_length} to #{json_quotes_array.length}"
puts "authors length"
puts "from #{original_authors_length} to #{json_authors_array.length}"

File.write('./quotes.json', json_quotes_array.to_json)
File.write('./authors.json', json_authors_array.to_json)

