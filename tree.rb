class Tree

  attr_reader :children
  attr_accessor :value, :board
  
  def initialize
    @children = Array.new
  end
  
  def add_child(tree)
    @children << tree
  end

end
