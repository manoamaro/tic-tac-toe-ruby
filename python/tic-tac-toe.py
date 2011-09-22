WIN = 1
DRAW = 0
LOSS = -1
PLAYER1 = 0
PLAYER2 = 1
best_move = 0

def mark(board, player, point):
  if 0 < point > 8:
    return false
  if board[point] == null:
    board[point] = player
    return true
  else:
    return false
    

