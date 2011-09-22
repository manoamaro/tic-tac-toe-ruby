#encoding:UTF-8

WIN = 1
DRAW = 0
LOSS = -1
PLAYER1 = 0
PLAYER2 = 1
$best_move = 0

def mark(board, player, point)
  if point < 0 || point > 8
    return false
  end
  if board[point].nil?
    board[point] = player
    true
  else
    false
  end
end

def unmark(board, point)
  if point < 0 || point > 8
    return false
  end
  board[point] = nil
end

def full_board?(board)
  board.index(nil).nil?
end

def position_empty?(board, pos)
  board[pos].nil?
end

def evaluate(board, player)
  win = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  if board.empty?
    return false
  end
  win.each do |test|
    r = board.values_at(*test).uniq
    if r.size == 1 && r[0] == player
      return true
    end
  end
  return false
end


def other(player)
  if player == PLAYER1
    PLAYER2
  else
    PLAYER1
  end
end


def bestMove(board, player, alpha, beta)
  return DRAW if full_board?(board)
  return WIN  if evaluate(board,player)
  return LOSS if evaluate(board,other(player))
  best_score = alpha
  (0..8).each do |i|
    break if best_score > beta
    if position_empty?(board, i)
      mark(board, player, i)
      score = -bestMove(board,other(player), -beta, -alpha)
      if score > best_score
        $best_move = i
        best_score = score
      end
      unmark(board, i)
    end
  end
  return best_score
end

def print_board(board)
  a = board.collect{ |x| x == PLAYER1 ? 'x' : x == PLAYER2 ? 'o' : '_' }
  puts "#{a[0]}|#{a[1]}|#{a[2]}"
  puts "#{a[3]}|#{a[4]}|#{a[5]}"
  puts "#{a[6]}|#{a[7]}|#{a[8]}"
end
