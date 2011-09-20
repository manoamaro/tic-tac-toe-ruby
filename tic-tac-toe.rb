#encoding:UTF-8
require './ab_tree.rb'

PLAYER1 = 1
PLAYER2 = 2
WIN = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

player1 = []
player2 = []

def evaluate(p1,p2)
  if p1.empty? or p2.empty?
    return 0
  end
  WIN.each do |test|
    if (test - p1).empty?
      return 1
    end
    if (test - p2).empty?
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

playing_now = 1

while(true)
  if playing_now == 1
    puts "Player 1, digite a posição: "
    p = gets
    player1 << p.to_i
    playing_now = 2
  else
    puts "Player 2, digite a posição: "
    p = gets
    player2 << p.to_i
    playing_now = 1
  end
  resultado = evaluate(player1,player2)
  puts "\nResultado: #{evaluate(player1,player2)}\n"
  if (resultado == 1 || resultado == 2 || player1.size + player2.size == 9)
    puts "Player 1: #{player1}"
    puts "Player 2: #{player2}"
    break
  end
end
