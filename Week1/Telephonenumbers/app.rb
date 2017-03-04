require "csv"
bad_numbers = File.read("import_telephone_numbers.csv")
File.open("export_telephone_numbers.csv", "w") do |file|
  bad_numbers.each_line do |line|
  number = line.gsub(/\D/n, "")
  if (number.length == 10)
	number = "1#{number}"
  end
	good_number = "#{number[0]}-#{number[1...4]}-#{number[4...7]}-#{number[7...11]}"
	file << "#{good_number}".gsub(/\n/, "") + "\n"
  end
end