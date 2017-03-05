require "csv"
require 'soda/client'

client = SODA::Client.new({:domain => "data.cityofnewyork.us", :app_token => "1xtHEeIwbd4SwSfyS6gan9Lpvr"})
results = client.get("he7q-3hwy", :$limit => 5000)
puts "Got #{results.count} results. Dumping first results:"
results.first.each do |k, v|
  puts "#{k}: #{v}"
end