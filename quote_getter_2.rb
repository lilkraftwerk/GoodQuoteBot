require 'httparty'
require 'json'

quote_url = 'http://www.quotedb.com/quote/quote.php?action=random_quote&=&=&'

quote = HTTParty.get(quote_url)

authors = []
quotes = []


def get_quote
  quote_url = 'http://www.quotedb.com/quote/quote.php?action=random_quote&=&=&'
  raw_quote = HTTParty.get(quote_url)
  quote = /^.+\('(.+)<br>/.match(raw_quote.parsed_response)[1] if /^.+\('(.+)<br>/.match(raw_quote.parsed_response)
  author = /.+>(.+)<\/a/.match(raw_quote.parsed_response)[1] if /.+>(.+)<\/a/.match(raw_quote.parsed_response)
  [quote, author]
end

2000.times do |x|
  this_quote = get_quote
  quotes << this_quote[0] if this_quote[0]
  authors << this_quote[1] if this_quote[1]
  if x % 10 == 0
    puts "#{x}..."
  end
end

p quotes
p authors

json_quotes_array = quotes.uniq.to_json
json_authors_array = authors.uniq.to_json

File.write('./newquotes.json', json_quotes_array)
File.write('./authors.json', json_authors_array)



# quote_match = /^.+\('(.+)<br>/.match(quote.parsed_response)
# author_match = /.+>(.+)<\/a/.match(quote.parsed_response)

# quote = quote_match[1]
# author = author_match[1]

# puts quote
# puts author