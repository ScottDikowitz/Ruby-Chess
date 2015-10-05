require_relative 'piece'
require_relative 'display'


class MoveError < StandardError
end

class Board

  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    newboard
  end

  def [](pos)
    x,y = pos
    self.grid[x][y]
  end

  def []=(pos, piece)
    x,y = pos
    self.grid[x][y] = piece
  end

  def occupied?(pos)
    return true if self[pos]
    false
  end

  def newboard
    non_pawns = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (0..7).each do |i|
      self[[0,i]] = non_pawns[i].new([0,i],:b,self)
      self[[1,i]] = Pawn.new([1,i],:b,self)
      self[[6,i]] = Pawn.new([1,i],:w,self)
      self[[7,i]] = non_pawns[i].new([7,i],:w,self)
    end
  end


  def move(start, end_pos)
    raise MoveError "There is no piece at that location." if self[start].nil?
    raise MoveError "Cannot move there." unless (
      self[start].valid_moves.include?(end_pos))

    self[end_pos] = self.grid[start]
    self[start] = nil
  end
end
