require './ab_tree.rb'

PLAYER1 = 1
PLAYER2 = 2
WIN = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

player1 = [0,1,3]
player2 = [0,3,6]

def evaluate(p1,p2)
  WIN.each do |test|
    if p1 & test == test
      return 1
    end
    if p2 & test == test
      return -1
    end
  end
  return 0
end


def not_p(player)
  if player == PLAYER1
    PLAYER2
  else
    PLAYER1
  end
end

def alphabeta(node, depth, alpha, beta, player)
  if depth == 0 || node.children.empty?
    return node.value
  end
  if player == PLAYER1
    node.children.each do |child|
      alpha = [alpha, alphabeta(child, depth - 1, alpha, beta, not_p(player))].max
      if beta <= alpha
        break
      end
    end
    return alpha
  else
    node.children.each do |child|
      beta = [beta, alphabeta(child), depth - 1, alpha, beta, not_p(player)].min
      if beta <= alpha
        break
      end
    end
    return beta
  end
end
