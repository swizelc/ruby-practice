
# tik-tac-toe game

@board = [["1","2","3"],["4","5","6"],["7","8","9"]]

# draws the board
def draw_grid
  @board.length.times { |i|
    puts "    #{@board[i][0]} |   #{@board[i][1]} |   #{@board[i][2]} ".center(48)
    unless i == 2
      puts "----------------".center(50)
    end
  }
end


def get_move
  draw_grid()
  puts "Enter the number where you'd like to play your turn: "
  puts "Press x to quit"
  move = gets.chomp
  if move == "x"
    puts "Bye!"
    exit
  end
  # input can only be the number that is still on the board (i.e empty spaces)
  while !(@board.flatten.include?(move)) do
    puts "Please enter a valid number"
    move = gets.chomp
  end
  return move
end

def update_board(move, player)
  #find the space through the number
  @board.each { |x|
    x.each { |y|
      if y == move
        #reference by index and change it
        player == "1" ? (@board[(@board.index(x))][x.index(y)] = "X") : (@board[(@board.index(x))][x.index(y)] = "O")
      end
    }
  }
end

def check(player)
  #checking for an in identical row
  @board.each do |x|
    if x.uniq.length == 1
      puts "Player #{player} wins".center(50, "~")
      return true
    end
  end
  #checking for identical column
  for i in 0..2 do
    if @board[0][i] == @board[1][i] && @board[1][i]== @board[2][i]
      puts "Player #{player} wins".center(50, "~")
      return true
    end
  end
  #checking for across from either side
  if (@board[0][0] == @board[1][1] && @board[1][1]== @board[2][2]) || (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0])
    puts "Player #{player} wins".center(50, "~")
    return
  end
  return false
end

flag = false
turn = 1
while flag == false do
  #when turn is odd its player 1
  turn % 2 != 0 ? (player = "1") : (player = "2")
  puts "Turn : Player #{player}".center(50)
  move = get_move
  update_board(move,player)
  flag = check(player)
  turn += 1
  # check if draw
  if @board.flatten.uniq.length == 2
    puts "It's a draw".center(50,"~")
    flag = true
  end
end
