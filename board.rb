require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'piece'
require_relative 'display'
require 'byebug'


class MoveError < StandardError
end

class Board

  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    newboard
    nil
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
      self[[6,i]] = Pawn.new([6,i],:w,self)
      self[[7,i]] = non_pawns[i].new([7,i],:w,self)
    end
  end


  def move(start, end_pos)
    raise MoveError "There is no piece at that location." if self[start].nil?
    raise MoveError "Cannot move there." unless (
      #Uncomment when we write valid_moves
      self[start].valid_moves.include?(end_pos))

    self[end_pos] = self[start]
    self[start] = nil
    if self[end_pos].class == Pawn
      self[end_pos].moved = true
    end
    self[end_pos].pos = end_pos
    nil
  end

  def move!(start, end_pos)
    self[end_pos] = self[start]
    self[start] = nil
    self[end_pos].pos = end_pos
  end

  def dup
    board_dup = Board.new
    self.grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idy|
        if piece
          board_dup[[idx, idy]] = piece.class.new([idx, idy], piece.color, board_dup)
        else
          board_dup[[idx, idy]] = nil
        end
      end
    end
    board_dup
  end

  def checkmate?(color)
    mate = true

    self.grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idy|
        if piece && (piece.color == color)
          mate = mate && piece.valid_moves.empty?
        end
      end
    end

    mate
  end

  def in_check?(color)
    king_pos = nil
    self.grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idy|
        if !piece.nil?
          king_pos = [idx, idy] if piece.class == King && piece.color == color
        end
      end
    end

    self.grid.each do |row|
      row.each do |piece|
        if !piece.nil?
          return true if piece.moves.include?(king_pos)
        end
      end
    end

    false
  end
end
