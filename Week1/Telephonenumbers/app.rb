require "csv"
badnumbers = File.read("import_telephone_numbers.csv")
File.open("export_telephone_numbers.csv", "w") do |file|
	badnumbers.each_line do |number|
		orgnum = number
		if (number.length == 11)
			number = "1#{number}"
		end
		newnumber = number.gsub(/\D/n, "")
		goodnumber = "#{newnumber[0]}-#{newnumber[1...4]}-#{newnumber[4...7]}-#{newnumber[7...11]}"
		puts goodnumber
		file << "#{orgnum} --> #{goodnumber}".gsub(/\n/, "") + "\n"
	end
end