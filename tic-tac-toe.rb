#encoding:UTF-8
require './tree.rb'

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
    if board[test[0]] == player && board[test[1]] == player && board[test[2]] == player
      return true
    end
  end
  return false
end


def _not(player)
  if player == PLAYER1
    PLAYER2
  else
    PLAYER1
  end
end

def bestMove(board, player, alpha, beta)
  best_score = nil
  if evaluate(board,player)
    return WIN
  else
    if evaluate(board,_not(player))
      return LOSS
    else
      if full_board?(board)
        return DRAW
      else
        best_score = alpha
        for i = 0, i < 8 && best_score < beta, i++
          if position_empty?(board, i)
            mark(board, player, i)
            score = -bestMove(board,_not(player), -beta, -alpha)
            if score > best_score
              puts i
              $best_move = i
              best_score = score
            end
            unmark(board, i)
          end
        end
      end
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
