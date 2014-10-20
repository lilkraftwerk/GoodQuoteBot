# encoding UTF-8

require 'httparty'
require 'json'

quote_url = 'http://www.quotedb.com/quote/quote.php?action=random_quote&=&=&'

quote = HTTParty.get(quote_url)

quotes_file = File.open('quotes.json').read
quotes = JSON.parse(quotes_file)

authors_file = File.open('authors.json').read
authors = JSON.parse(authors_file)

def get_quote
  quote_url = 'http://www.quotedb.com/quote/quote.php?action=random_quote&=&=&'
  raw_quote = HTTParty.get(quote_url)
  quote = /^.+\('(.+)<br>/.match(raw_quote.parsed_response)[1] if /^.+\('(.+)<br>/.match(raw_quote.parsed_response)
  author = /.+>(.+)<\/a/.match(raw_quote.parsed_response)[1] if /.+>(.+)<\/a/.match(raw_quote.parsed_response)
  [quote, author]
end

500.times do |x|
  this_quote = get_quote
  quotes << this_quote[0] if this_quote[0]
  authors << this_quote[1] if this_quote[1]
  if x % 10 == 0
    puts "#{x}..."
  end
end


json_quotes_array = quotes.uniq.to_json
json_authors_array = authors.uniq.to_json

puts "quotes length"
p json_quotes_array.length
puts "authors length"
p json_authors_array.length

File.write('./quotes.json', json_quotes_array)
File.write('./authors.json', json_authors_array)

