require 'google_drive'
require 'pry'
session = GoogleDrive::Session.from_config("config.json")
$ws = session.spreadsheet_by_key("1f_hI23_Wu1GxbdPdxBgNkX85pmMAo1pHOGpGfEe8SEE").worksheets[0]

$table = [[$ws[2,1], $ws[2,2], $ws[2,3]], [$ws[3,1], $ws[3,2], $ws[3,3]], [$ws[4,1], $ws[4,2], $ws[4,3]]]
$turn = 0
def check_move(move) #If move is illegal
	if $ws[move[0], move[1]] == "X" || $ws[move[0], move[1]] == "O"
		puts "Move chosen was illegal, please try again"
		return true
	end
end
def check_game #If move makes the win
	hori = [[$ws[2,1], $ws[3,1], $ws[4,1]], [$ws[2,2], $ws[3,2], $ws[4,2]], [$ws[2,3], $ws[3,3], $ws[4,3]]]
	vert = [[$ws[2,1], $ws[2,2], $ws[2,3]], [$ws[3,1], $ws[3,2], $ws[3,3]], [$ws[4,1], $ws[4,2], $ws[4,3]]]
	diag = [[$ws[2,1], $ws[3,2], $ws[4,3]], [$ws[4,3], $ws[3,2], $ws[2,3]]]
	win = [hori, vert, diag]
	for poss in win
		x = 0
		o = 0
		for w in poss
			if w == "X"
				x +=1
			elsif w == "W"
				o += 1
			end
		end
		if x == 3
			$ws[5,1] = "X WINS"
		elsif o == 3
			$ws[5,1] = "O WINS" 
		end
		$ws.save
	end
	return false if $turn == 9
end
def answer #Find turn/xoro
	ans = ""
	$turn % 2 == 0 ? ans = "X" : ans = "O"
	$turn += 1
	return ans
end
def comp_pick #Computer pick
	if check_game
		#puts "Computer will make a move..."
		row = rand(2..4) 
		col = rand(1..3)
		if check_move([row,col]) #checks for bad move
			comp_pick
		else
			$ws[row,col] = answer
			puts "Computer has chosen a move (#{row-1}, #{col})"
			$ws.save
			pick
		end
	end
end
def pick #Player pick
	if check_game
		puts "You are making a move..."
		inp = gets.chomp.split(",") #input is x,y
		input = [inp[0].to_i + 1, inp[1].to_i]
		if check_move(input) #checks for bad move
			pick
		else
			$ws[input[0],input[1]] = answer
			puts "You have made a move"
			$ws.save
			comp_pick
		end
	end
end
def decide #cointoss to see who goes first
	message = ["You are the first player to move","Computer is the first player to move"]
	first = ["Player", "Computer"]
	move = [pick,comp_pick]
	cointoss = rand(2)
	puts message[cointoss]
	$ws[1,7] = "Player 1: #{first[cointoss]}"
	$ws[1,8] = "Player 2: #{(first - [first[cointoss]])[0]}"
	$ws.save
	move[cointoss]
end
def start #Init
	$ws.delete_rows(1,5)
	$table.each_with_index{|val, x|
		val.each_with_index{|space, y|
			$ws[x + 2,y + 1] = "#{x+1}, #{y+1}"
		}
	}
	$ws[1,1] = "TicTacToe"
	$ws[1,5] = "Game #: "
	$ws[1,6] = "Date: #{Time.new.inspect}"
	$ws.save
end
start
decide