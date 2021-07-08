# frozen_string_literal: true

# TicTacToeBoard handles the hash that holds the board's data
class TicTacToeBoard
  attr_reader :board

  def initialize
    @board = {  0 => ' ', 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ',
                7 => ' ', 8 => ' ' }
  end

  def print_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def set_position(position, character)
    if @board[position] == ' ' && position >= 0 && position <= 8
      @board[position] = character
      position
    else
      -1
    end
  end

  def test_game(character)
    sequences = [[0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6]]
    found = false
    sequences.each_with_index do |_serie, index|
      a = @board[sequences[index][0]]
      b = @board[sequences[index][1]]
      c = @board[sequences[index][2]]
      found = (a == b && b == c && c == character)
      break if found
    end
    found
  end
end

# Some comments on this class
class Player
  attr_reader :name, :character

  def initialize(id, character)
    puts "Enter Name (player #{id} will be using ->#{character}):"
    name = gets.chomp

    @name = name.empty? ? "Player #{id}" : name
    @character = character
  end
end

board = TicTacToeBoard.new
board.print_board

player01 = Player.new(1, 'x')
player02 = Player.new(2, 'o')

puts "Ready...player #{player01.name} (#{player01.character}).."
puts "Ready...player #{player02.name} (#{player02.character}).."

iteration = 0
gturn = iteration.even?
game_test = false
current_player = gturn ? player01 : player02

loop do
  puts "#{current_player.name}, please enter a position..."
  position_selected = gets.chomp.to_i
  position_selected = board.set_position(position_selected, current_player.character)

  # returns -1 means not a valid position selected
  next if position_selected == -1

  game_test = board.test_game(current_player.character)
  board.print_board

  break if iteration == 8 || game_test

  # gturn, to swap turns
  iteration += 1
  gturn = iteration.even?
  current_player = gturn ? player01 : player02
end

if game_test
  puts "Winner is #{current_player.name} ->#{current_player.character}"
else
  puts 'Game was draw!'
end
board.print_board
