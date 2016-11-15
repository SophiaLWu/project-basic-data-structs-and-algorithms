# Represents a knight on the chess board
class Knight

  def initialize
    @board = Board.new
  end

  # Given a start position and a finish position,
  # finds the shortest path from the start to the finish
  def move(start, finish)
    unless @board.valid_position?(start) && @board.valid_position?(finish)
      return invalid_inputs
    end

    queue = [Node.new(start)]
    node = Node.new

    until node.data == finish
      node = queue.shift
      @board.moves_as_children(node)
      node.children.each { |child| queue << child }
    end

    print_path(create_path(node))
  end

  # Prints a message to the user if input is invalid
  def invalid_inputs
    puts "Invalid input! Your positions must have x and y coordinates "\
         "between 0 and 7."
  end

  # Given a node, returns the shortest path to get to that node as a 2D array
  def create_path(node)
    path = []
    until node == nil
      path << node.data
      node = node.parent
    end
    path.reverse
  end

  # Given a path as a 2D array, prints output outlining the path to the user
  def print_path(path)
    printed = "You made it in #{path.length - 1} moves! Here's your path:\n"
    path.each { |position| printed += "#{position}\n"}
    puts printed.chomp 
  end

end


# Represents the chess board
class Board

  # Given a position on the board, returns all the valid
  # positions that the knight can move to as a 2-D array
  def possible_moves(position)
    x, y = position
    moves = [[x - 2, y + 1], [x - 2, y - 1],
             [x - 1, y + 2], [x - 1, y - 2],
             [x + 1, y + 2], [x + 1, y - 2],
             [x + 2, y + 1], [x + 2, y - 1]]

    moves.select { |position| valid_position?(position) }
  end

  # Adds all possible moves from a position as children
  def moves_as_children(node)
    possible_moves(node.data).each do |move|
      node.children << Node.new(move, node)
    end
  end

  # Returns true if the position is within the boundaries of the board
  def valid_position?(position)
    return position.all? { |value| value.between?(0,7) }
  end

end


# Represents a single position after a move on the board, where @parent is
# the position it moved from and @children represents all possible moves
class Node
  attr_accessor :data, :parent, :children

  def initialize(data=nil,parent=nil)
    @data = data
    @parent = parent
    @children = []
  end

end


# TESTS:
# Uncomment to check results
# k = Knight.new
# k.move([3,3],[4,9])
# k.move([-1,3],[4,3])
# k.move([3,8],[4,3])
# k.move([3,3],[4,3])
# k.move([4,7],[7,1])
# k.move([0,0],[7,7])
# k.move([1,0],[0,0])
# k.move([5,5],[5,5])
