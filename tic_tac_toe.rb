class Board
  attr_accessor :pl1, :pl2, :turns

  def initialize
    @turns = 0
    @board = Array.new(9, '_')
    @winning_arr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  end

  def play
    if !pl1
      welcome_mes
    end
    print_board
    turn(@pl1)
    if win?
      game_over(@pl1)
    else
      print_board
      abort("Game ended with a draw.") if @turns >= 9
      turn(@pl2)
      if win?
        game_over(@pl2)
      else
        play
      end
    end
  end

  private

  def print_board
    puts "Board:"
    for i in 0..@board.length do
      print @board[i]
      if (i+1) % 3 == 0
        puts
      end
    end
  end

  def welcome_mes
    puts "Welcome, this is a Tic Tac Toe game!"
    puts "Name of the first player:"
    name = gets.chomp
    puts "You can choose your color: X or O"
    color = gets.chomp == "X" ? "X" : "O"
    @pl1 = {name: name, color: color}
    puts "Name of the second player:"
    name = gets.chomp
    color = "XO".delete color
    @pl2 = {name: name, color: color}
  end

  def turn(player)
    puts player[:name] + " its your turn now, please choose a position for your color! 1 to 9"
    poz = error_check(gets.chomp.to_i)
    if @board[poz-1] == "_"
       @board[poz-1] = player[:color]
     else
       puts "That position is already taken, choose a new one!"
       turn(player)
    end
    @turns += 1
  end

  def win?
    @winning_arr.each do |line|
      count_x = 0
      count_o = 0
      line.each do |el|
        count_x +=1 if @board[el] == "X"
        count_o +=1 if @board[el] == "O"
      end
      return true if count_x == 3 || count_o ==3
    end
    false
  end

  def game_over(player)
    puts "Game over! Palyer #{player[:name]} won."
    print_board
  end

  def error_check poz
    until poz.between?(1,9)
      puts "Valid positions are 1 to 9!"
      poz=gets.chomp.to_i
    end
    poz
  end
end

b = Board.new
b.play
