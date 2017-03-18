require "csv"
bad_numbers = File.read("import_telephone_numbers.csv")
File.open("export_telephone_numbers.csv", "w") do |file|
  bad_numbers.each_line do |line|
  number = line.gsub(/\D/n, "")
  number = "1#{number}" if number.length == 10
	good_number = "#{number[0]}-#{number[1...4]}-#{number[4...7]}-#{number[7...11]}"
	"#{good_number}" == good_number
	file << good_number + "\n"
  end
end