#unicoding:utf-8
require './tic-tac-toe.rb'
require './interface.rb'

board = Array.new(9)

while(true)

  bestMove(board, PLAYER2, WIN, LOSS)
  printf "Player 2 jogou #{$best_move} \n"
  mark(board, PLAYER2, $best_move)
  print_board(board)

  case
    when evaluate(board,PLAYER2)
      puts "Player 2 ganhou."
      break
    when full_board?(board)
      puts "Empate"
      break
  end

  printf "Player 1, digite a posição: "
  p = gets
  mark(board, PLAYER1, p.to_i)
  print_board(board)

  case
    when evaluate(board,PLAYER1)
      puts "Player 1 ganhou."
      break
    when full_board?(board)
      puts "Empate"
      break
  end


end
