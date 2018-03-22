require 'net/http'
require 'uri'
require 'rexml/document'
require_relative 'lib/currency'

uri = URI.parse("https://www.cbr-xml-daily.ru/daily_utf8.xml")
response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)

all_currency = doc.root.to_a

usd = nil

all_currency.each do |node|
  usd = Currency.from_node(node) if node.elements['Name'].text == 'Доллар США'
end

usd_vs_rub = usd.value.sub(',','.').to_f

puts "\nКурс доллара США к рублю сегодня: #{usd}"

puts "\nСколько у вас рублей?\n"

rub_amount = STDIN.gets.to_i

puts "Сколько у вас долларов?\n"

usd_amount = STDIN.gets.to_i

usd_to_rub = usd_vs_rub*usd_amount

if usd_to_rub > rub_amount
  puts "Для того чтобы уровнять сумму рублей и долларов США"
  puts "Вам необходимо продать #{(((usd_to_rub - rub_amount)/2)/usd_vs_rub).round(2)} дол."
else
  puts "Для того чтобы уровнять сумму рублей и долларов США"
  puts "Вам необходимо продать #{((rub_amount - usd_to_rub)/2).round(2)} руб."
end