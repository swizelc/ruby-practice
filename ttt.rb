
# tik-tac-toe game

@board = [["1","2","3"],["4","5","6"],["7","8","9"]]
O = "\u{2B55}"
X = "\u{274C}"

# draws the board
def draw_grid
  @board.length.times { |i|
    puts "  #{@board[i][0]}  |  #{@board[i][1]}  |  #{@board[i][2]}  "
    unless i == 2
      puts "------------------"
    end
  }
end

def update_board(move, player)
  #find the space through the number
  @board.each { |x|
    x.each { |y|
      if y == move
        #reference by index and change it
        player == "1" ? (@board[(@board.index(x))][x.index(y)] = X) : (@board[(@board.index(x))][x.index(y)] = O)
      end
    }
  }
end

def get_move
  puts "Enter the number where you'd like to play your turn: "
  puts "Press x to quit"
  move = gets.chomp
  # input can only be the number that is still on the board (i.e empty spaces)
  while !(@board.flatten.include?(move)) do
    if move == "x"
      puts "Bye!"
      exit
    end
    puts "Please enter a valid number"
    move = gets.chomp
  end
  return move
end

def check(player)
  #checking for an in identical row
  @board.each do |x|
    if x.uniq.length == 1
      display
      puts "Player #{player} wins".center(50, "~")
      return true
    end
  end
  #checking for identical column
  for i in 0..2 do
    if @board[0][i] == @board[1][i] && @board[1][i]== @board[2][i]
      display
      puts "Player #{player} wins".center(50, "~")
      return true
    end
  end
  #checking for across from either side
  if (@board[0][0] == @board[1][1] && @board[1][1]== @board[2][2]) || (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0])
    display
    puts "Player #{player} wins".center(50, "~")
    return true
  end
  return false
  end

def display
  system "clear"
  draw_grid
end

flag = false
turn = 1
while flag == false do
  display
  #when turn is odd its player 1
  turn % 2 != 0 ? (player = "1") : (player = "2")
  puts "Turn : Player #{player}".center(50)
  move = get_move
  update_board(move,player)
  flag = check(player)
  turn += 1
  # check if draw
  if @board.flatten.uniq.length == 2 && flag == false
    puts "It's a draw".center(50,"~")
    flag = true
  end
end
