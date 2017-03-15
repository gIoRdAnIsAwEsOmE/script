require 'csv'
require 'json'
entrances = CSV.open('csv/subwayentrances.csv', :headers => true).map { |x| x.to_h }.to_json
stations = CSV.open('csv/subwaystations.csv', :headers => true).map { |x| x.to_h }.to_json
File.open("subways.json", "w+") do |subway|
  subway << "[" + entrances + ","
  subway << stations + "]"
=begin
  [0] = entrances
  [1] = stations
=end
end
    
