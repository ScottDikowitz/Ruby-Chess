require_relative 'piece'
class SlidingPiece < Piece
  def initialize(pos, color, board)
    super
  end

  def moves
    move_array = []
    move_dirs.each do |delta|
      new_pos = pos.dup
      temp = [new_pos.first + delta.first, new_pos.last + delta.last]
      while temp.all? { |x| x.between?(0,7) }
        #p temp
        if board.occupied?(temp) && board[temp].color != color
          move_array << temp
          temp = [-1,-1]
        elsif board.occupied?(temp)
          temp = [-1,-1]
        end
        if temp.all? { |x| x.between?(0,7) }
          move_array << temp
          temp = [temp.first + delta.first, temp.last + delta.last]
        end
      end
    end
    move_array
  end

  def move_dirs
    self.class.move_dirs
  end
end

class Queen < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :w ? "♕" : "♛"
  end

  def move_dirs
    [1, 0, -1].repeated_permutation(2).to_a.delete_if{|a| a == [0,0]}
  end

  def moves
    super
  end
end

class Bishop < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :w ? "♗" : "♝"
  end

  def move_dirs
    [1, -1].repeated_permutation(2).to_a
  end

  def moves
    super
  end
end

class Rook < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :w ? "♖" : "♜"
  end

  def move_dirs
    [[1,0], [0,1], [-1,0], [0,-1]]
  end

  def moves
    super
  end
end
