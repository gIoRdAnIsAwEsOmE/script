require 'google_drive'

session = GoogleDrive::Session.from_config("config.json")
$ws = session.spreadsheet_by_key("1f_hI23_Wu1GxbdPdxBgNkX85pmMAo1pHOGpGfEe8SEE").worksheets[0]

$table = [[$ws[2,1], $ws[2,2], $ws[2,3]], [$ws[3,1], $ws[3,2], $ws[3,3]], [$ws[4,1], $ws[4,2], $ws[4,3]]]
$turn = 0

def check_game
	
end
def comp_pick
	
	pick
end
def pick
	inp = gets.chomp.split(",") #input is x,y
	input = [inp[0].to_i + 1, inp[1].to_i]
	answer = "X" || "O" if $turn % 2 == 0
	$turn += 1
	$ws[input[0],input[1]] = answer
	$ws.save
	puts $ws[input[0],input[1]]
	comp_pick
end
puts $turn
pick